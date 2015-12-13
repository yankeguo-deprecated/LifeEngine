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
  //TODO: implement all kind of common operators
  return NO;
}

@end