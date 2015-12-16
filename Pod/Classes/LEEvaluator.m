//
// Created by Yanke Guo on 15/12/13.
//

#import "LEEvaluator.h"

#import "LEEvaluator+Operators.h"

@interface LEEvaluator ()

@property(nonatomic, strong) NSRegularExpression *__nonnull expressionI18n;

@property(nonatomic, strong) NSRegularExpression *__nonnull expressionResource;

@end

@implementation LEEvaluator

- (instancetype)init {
  if (self = [super init]) {
    self.expressionI18n = [NSRegularExpression regularExpressionWithPattern:@"@\\{(.+?)\\}"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
    self.expressionResource = [NSRegularExpression regularExpressionWithPattern:@"\\$\\{(.+?)\\:\\:(.+?)\\}"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
  }
  return self;
}


- (__kindof NSObject *__nullable)resolveObjectForKey:(NSString *__nonnull)key
                                        resourceType:(NSString *__nonnull)resourceType {
  return [self.dataSource evaluator:self resolveObjectForKey:key resourceType:resourceType];
}

- (NSString *__nonnull)resolveObjectAsStringForKey:(NSString *__nonnull)key
                                      resourceType:(NSString *__nonnull)resourceType {
  return [self stringFromObject:[self resolveObjectForKey:key resourceType:resourceType]];
}

- (NSNumber *__nonnull)resolveObjectAsNumberForKey:(NSString *__nonnull)key
                                      resourceType:(NSString *__nonnull)resourceType {
  return [self numberFromObject:[self resolveObjectForKey:key resourceType:resourceType]];
}

- (NSString *__nonnull)evaluateString:(NSString *__nonnull)string {
  NSMutableString *result = [NSMutableString stringWithString:string];
  NSTextCheckingResult *matchResult = nil;
  while ((matchResult = [self.expressionResource firstMatchInString:result
                                                            options:0
                                                              range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 3);
    NSString *resourceType = [result substringWithRange:[matchResult rangeAtIndex:1]];
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:2]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self resolveObjectAsStringForKey:key resourceType:resourceType]];
  }
  while ((matchResult = [self.expressionI18n firstMatchInString:result
                                                        options:0
                                                          range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 2);
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:1]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self.dataSource evaluator:self
                                   resolveLocalizedStringForKey:key]];
  }
  return [result copy];
}

- (NSNumber *__nonnull)evaluateStringAsNumber:(NSString *__nonnull)string {
  NSString *stringResult = [self evaluateString:string];
  if (stringResult.length == 0) {
    return @(0);
  }
  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  formatter.numberStyle = NSNumberFormatterDecimalStyle;
  NSNumber *result = [formatter numberFromString:stringResult];
  if (result == nil) {
    return @(0);
  }
  return result;
}

- (BOOL)evaluateConditionDictionary:(NSDictionary *__nonnull)dictionary {
  NSParameterAssert([dictionary isKindOfClass:[NSDictionary class]]);
  //  Try 'And'
  NSArray *andSequence = dictionary[@"And"];
  if (andSequence) {
    NSParameterAssert(dictionary.count == 1);
    return [self evaluateAndOperator:andSequence];
  }
  //  Try 'Or'
  NSArray *orSequence = dictionary[@"Or"];
  if (orSequence) {
    NSParameterAssert(dictionary.count == 1);
    return [self evaluateOrOperator:orSequence];
  }
  //  Try 'Not'
  NSDictionary *notSequence = dictionary[@"Not"];
  if (notSequence) {
    NSParameterAssert(dictionary.count == 1);
    return [self evaluateNotOperator:notSequence];
  }
  //  Using Common Operators
  return [self evaluateConditionWithCommonOperatorsOnly:dictionary];
}

- (void)evaluateActionDictionary:(NSDictionary *__nonnull)action {
  NSParameterAssert([action isKindOfClass:[NSDictionary class]]);
  [action enumerateKeysAndObjectsUsingBlock:^(NSString *actionName, NSDictionary *actionTarget, BOOL *stop) {
    if ([actionName isEqualToString:@"Set"]) {
      [actionTarget enumerateKeysAndObjectsUsingBlock:^(NSString *key, __kindof NSObject *obj, BOOL *stop2) {
        [self evaluateSetActionWithMixin:obj forKey:key];
      }];
    } else if ([actionName isEqualToString:@"Add"]) {
      [actionTarget enumerateKeysAndObjectsUsingBlock:^(NSString *key, __kindof NSObject *obj, BOOL *stop2) {
        [self evaluateAddActionWithMixin:obj forKey:key];
      }];
    }
  }];
}

- (void)evaluateActionDictionaries:(NSArray<NSDictionary *> *__nonnull)actions {
  [actions enumerateObjectsUsingBlock:^(NSDictionary *action, NSUInteger idx, BOOL *stop) {
    [self evaluateActionDictionary:action];
  }];
}

- (void)evaluateConditionalActionDictionary:(NSDictionary *__nonnull)conditionalAction {
  [self evaluateConditionalActionDictionaries:@[conditionalAction]];
}

- (void)evaluateConditionalActionDictionaries:(NSArray<NSDictionary *> *__nonnull)conditionalActions {
  NSParameterAssert([conditionalActions isKindOfClass:[NSArray class]]);

  [conditionalActions enumerateObjectsUsingBlock:^(NSDictionary *conditionalAction, NSUInteger idx, BOOL *stop) {
    BOOL success = YES;
    NSDictionary *conditionDictionary = conditionalAction[@"If"];
    if ([conditionDictionary isKindOfClass:[NSDictionary class]]) {
      success &= [self evaluateConditionDictionary:conditionDictionary];
    }
    if (success) {
      //  do action
      [self evaluateActionDictionary:conditionalAction[@"Do"]];
      //  continue next clause on demand
      if (![conditionalAction[@"Continue"] boolValue]) {
        *stop = YES;
      }
    }
  }];
}

#pragma mark - Helpers

- (NSString *__nonnull)stringFromObject:(NSObject *__nullable)object {
  if ([object isKindOfClass:[NSString class]]) {
    return (NSString *) object;
  }
  if ([object isKindOfClass:[NSNumber class]]) {
    return [(NSNumber *) object stringValue];
  }
  return @"";
}

- (NSNumber *__nonnull)numberFromObject:(NSObject *__nullable)object {
  if ([object isKindOfClass:[NSString class]]) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter numberFromString:(NSString *) object];
  }
  if ([object isKindOfClass:[NSNumber class]]) {
    return (NSNumber *) object;
  }
  return @(0);
}

@end