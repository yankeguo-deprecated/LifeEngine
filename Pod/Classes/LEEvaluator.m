//
// Created by Yanke Guo on 15/12/13.
//

#import "LEEvaluator.h"

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

- (NSString *__nonnull)evaluateString:(NSString *__nonnull)string {
  NSMutableString *result = [NSMutableString stringWithString:string];
  NSTextCheckingResult *matchResult = nil;
  while ((matchResult = [self.expressionResource firstMatchInString:result
                                                            options:0
                                                              range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 3);
    NSString *type = [result substringWithRange:[matchResult rangeAtIndex:1]];
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:2]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self.dataSource evaluator:self resolveStringForKey:key resourceType:type]];
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

@end