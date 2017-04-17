//
//  LEEvaluator+Operators.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import "LEEvaluator+Operators.h"

@implementation LEEvaluator (Operators)

#pragma mark - Combination Operators

- (BOOL)evaluateAndOperator:(NSArray<NSDictionary *> *__nonnull)subConditions {
  NSParameterAssert([subConditions isKindOfClass:[NSArray class]]);
  NSParameterAssert(subConditions.count > 1);
  __block BOOL result = YES;
  [subConditions enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    BOOL subResult = [self evaluateConditionDictionary:dictionary];
    if (!subResult) {
      *stop = YES;
      result = NO;
    }
  }];
  return result;
}

- (BOOL)evaluateOrOperator:(NSArray<NSDictionary *> *__nonnull)subConditions {
  NSParameterAssert([subConditions isKindOfClass:[NSArray class]]);
  NSParameterAssert(subConditions.count > 1);
  __block BOOL result = NO;
  [subConditions enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    BOOL subResult = [self evaluateConditionDictionary:dictionary];
    if (subResult) {
      *stop = result = YES;
    }
  }];
  return result;
}

- (BOOL)evaluateNotOperator:(NSDictionary *__nonnull)dictionary {
  return ![self evaluateConditionDictionary:dictionary];
}

#pragma mark - Common Operators

- (BOOL)evaluateConditionWithCommonOperatorsOnly:(NSDictionary<NSString *, NSDictionary *> *__nonnull)dictionary {
  NSParameterAssert([dictionary isKindOfClass:[NSDictionary class]]);
  NSParameterAssert(dictionary.count > 0);
  __block BOOL result = YES;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL *stop) {
    BOOL subResult = [self evaluateCommonOperator:key combinedDictionary:obj];
    if (!subResult) {
      result = NO;
      *stop = YES;
    }
  }];
  return result;
}

- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator combinedDictionary:(NSDictionary<NSString *, __kindof NSObject *> *__nonnull)dictionary {
  NSParameterAssert([dictionary isKindOfClass:[NSDictionary class]]);
  NSParameterAssert(dictionary.count > 0);
  __block BOOL result = YES;
  [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
    BOOL subResult = [self evaluateCommonOperator:operator rawFrom:key rawMixin:obj];
    if (!subResult) {
      result = NO;
      *stop = YES;
    }
  }];
  return result;
}

- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator rawFrom:(NSString *__nonnull)rawFrom rawMixin:(__kindof NSObject *__nonnull)rawMixin {
  NSParameterAssert([rawFrom isKindOfClass:[NSString class]]);
  NSParameterAssert([rawMixin isKindOfClass:[NSString class]] ||
      [rawMixin isKindOfClass:[NSArray class]] ||
      [rawMixin isKindOfClass:[NSNumber class]]);
  NSArray<__kindof NSObject *> *array = (NSArray *) rawMixin;
  if (![array isKindOfClass:[NSArray class]]) {
    array = @[array];
  }
  NSParameterAssert(array.count > 0);
  __block BOOL result = NO;

  [array enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
    BOOL subResult = [self evaluateCommonOperator:operator rawFrom:rawFrom rawTo:obj];
    if (subResult) {
      result = *stop = YES;
    }
  }];

  return result;
}

- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator rawFrom:(NSString *__nonnull)rawFrom rawTo:(__kindof NSObject *__nonnull)rawTo {
  NSArray <NSString *> *fromComponents = [rawFrom componentsSeparatedByString:@"::"];
  NSParameterAssert(fromComponents.count == 2);
  NSString *resourceType = fromComponents.firstObject;
  NSString *resourceKey = fromComponents.lastObject;
  if ([operator hasPrefix:@"Number"]) {
    //  Extract from / to
    NSNumber *from = [self resolveObjectAsNumberForKey:resourceKey resourceType:resourceType];
    NSNumber *to = nil;
    if ([rawTo isKindOfClass:[NSNumber class]]) {
      to = (NSNumber *) rawTo;
    } else if ([rawTo isKindOfClass:[NSString class]]) {
      to = [self evaluateStringAsNumber:(NSString *) rawTo];
    } else {
      to = @(0);
    }
    NSComparisonResult result = [from compare:to];
    if ([operator isEqualToString:@"NumberEquals"]) {
      return result == NSOrderedSame;
    } else if ([operator isEqualToString:@"NumberNotEquals"]) {
      return result != NSOrderedSame;
    } else if ([operator isEqualToString:@"NumberGreaterThan"]) {
      return result == NSOrderedDescending;
    } else if ([operator isEqualToString:@"NumberGreaterThanEquals"]) {
      return result == NSOrderedDescending || result == NSOrderedSame;
    } else if ([operator isEqualToString:@"NumberLessThan"]) {
      return result == NSOrderedAscending;
    } else if ([operator isEqualToString:@"NumberLessThanEquals"]) {
      return result == NSOrderedAscending || result == NSOrderedSame;
    }
  } else if ([operator hasPrefix:@"String"]) {
    NSString *from = [self resolveObjectAsStringForKey:resourceKey resourceType:resourceType];
    if ([operator rangeOfString:@"Matches"].location != NSNotFound) {
      //  Extract to without evaluation
      NSString *to = nil;
      if ([rawTo isKindOfClass:[NSString class]]) {
        to = (NSString *) rawTo;
      } else if ([rawTo isKindOfClass:[NSNumber class]]) {
        to = [(NSNumber *) rawTo stringValue];
      } else {
        to = @"";
      }
      NSRegularExpression *toRegExp = [[NSRegularExpression alloc] initWithPattern:to options:0 error:nil];
      NSUInteger numberOfMatches = [toRegExp numberOfMatchesInString:from options:0 range:NSMakeRange(0, from.length)];
      if (toRegExp == nil) {
        NSLog(@"%@ is not a valid regexp", to);
        return NO;
      }
      if ([operator isEqualToString:@"StringMatches"]) {
        return numberOfMatches > 0;
      } else if ([operator isEqualToString:@"StringNotMatches"]) {
        return numberOfMatches == 0;
      }
    } else {
      NSString *to = nil;
      if ([rawTo isKindOfClass:[NSString class]]) {
        to = [self evaluateString:(NSString *) rawTo];
      } else if ([rawTo isKindOfClass:[NSNumber class]]) {
        to = [((NSNumber *) rawTo) stringValue];
      } else {
        to = @"";
      }
      if ([operator isEqualToString:@"StringEquals"]) {
        return [from isEqualToString:to];
      } else if ([operator isEqualToString:@"StringEqualsIgnoreCase"]) {
        return [[from lowercaseString] isEqualToString:[to lowercaseString]];
      } else if ([operator isEqualToString:@"StringNotEquals"]) {
        return ![from isEqualToString:to];
      } else if ([operator isEqualToString:@"StringNotEqualsIgnoreCase"]) {
        return ![[from lowercaseString] isEqualToString:[to lowercaseString]];
      }
    }
  } else if ([operator isEqualToString:@"Boolean"]) {
    NSObject *from = [self resolveObjectForKey:resourceKey resourceType:resourceType];
    NSNumber *to = (NSNumber *) rawTo;
    NSParameterAssert([to isKindOfClass:[NSNumber class]]);
    if ([from isKindOfClass:[NSString class]]) {
      //  NSString.length VS true/false
      return (to.boolValue && ((NSString *) from).length != 0) ||
          ((!to.boolValue) && ((NSString *) from).length == 0);
    } else if ([from isKindOfClass:[NSNumber class]]) {
      //  NSNumber.boolValue VS true/false
      return (to.boolValue && ((NSNumber *) from).boolValue) ||
          ((!to.boolValue) && (!((NSNumber *) from).boolValue));
    } else {
      //  NSObject == nil VS true/false
      return (to.boolValue && from != nil) ||
          ((!to.boolValue) && from == nil);
    }
  } else if ([operator isEqualToString:@"Null"]) {
    NSObject *from = [self resolveObjectForKey:resourceKey resourceType:resourceType];
    NSNumber *to = (NSNumber *) rawTo;
    NSParameterAssert([to isKindOfClass:[NSNumber class]]);
    //  NSObject == nil VS true/false
    return (to.boolValue && from == nil) ||
        ((!to.boolValue) && from != nil);
  }
  NSAssert(NO, @"operator not supported: %@", operator);
  return NO;
}

#pragma mark - Action

- (void)evaluateSetActionWithMixin:(__kindof NSObject *__nonnull)object forKey:(NSString *__nonnull)key {
  NSArray <NSString *> *keyComponents = [key componentsSeparatedByString:@"::"];
  NSParameterAssert(keyComponents.count == 2);
  NSString *resourceType = keyComponents.firstObject;
  NSString *resourceKey = keyComponents.lastObject;
  [self.dataSource evaluator:self setObject:object forKey:resourceKey resourceType:resourceType];
}

- (void)evaluateAddActionWithMixin:(__kindof NSObject *__nonnull)object forKey:(NSString *__nonnull)key {
  NSArray <NSString *> *keyComponents = [key componentsSeparatedByString:@"::"];
  NSParameterAssert(keyComponents.count == 2);
  NSString *resourceType = keyComponents.firstObject;
  NSString *resourceKey = keyComponents.lastObject;
  NSNumber *orignalNumber = [self resolveObjectAsNumberForKey:resourceKey resourceType:resourceType];
  NSNumber *number = object;
  if ([object isKindOfClass:[NSString class]]) {
    number = [self evaluateStringAsNumber:object];
  }
  NSParameterAssert([number isKindOfClass:[NSNumber class]]);
  NSDecimalNumber *finalNumber = [NSDecimalNumber decimalNumberWithString:[orignalNumber stringValue]];
  finalNumber = [finalNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[number stringValue]]];
  [self.dataSource evaluator:self setObject:finalNumber forKey:resourceKey resourceType:resourceType];
}

@end