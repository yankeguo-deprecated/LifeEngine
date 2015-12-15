//
//  LEEvaluator+Operators.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import <Foundation/Foundation.h>

#import "LEEvaluator.h"

@interface LEEvaluator (Operators)

#pragma mark - Combination Operators

- (BOOL)evaluateAndOperator:(NSArray<NSDictionary *> *__nonnull)subConditions;

- (BOOL)evaluateOrOperator:(NSArray<NSDictionary *> *__nonnull)subConditions;

- (BOOL)evaluateNotOperator:(NSDictionary *__nonnull)dictionary;

#pragma mark - Common Operators

/**
 *  {
 *    "StringEquals": {
 *      //...
 *    },
 *    "NumberLessThan": {
 *      //...
 *    }
 *  }
 *
 *  @param dictionary condition dictionary with common operators only
 *
 *  @return result
 */
- (BOOL)evaluateConditionWithCommonOperatorsOnly:(NSDictionary<NSString *, NSDictionary *> *__nonnull)dictionary;

/**
 *  {
 *    "context::key_1": [],
 *    "context::key_2": "a",
 *    "context::key_3": 2,
 *  }
 *
 *  @param operator   operator name
 *  @param dictionary combined expression to evaluate
 *
 *  @return result
 */

- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator combinedDictionary:(NSDictionary<NSString *, __kindof NSObject *> *__nonnull)dictionary;

/**
 *  "context::key_1" to NSString, NSNumber or NSArray
 *
 *  @param operator operator
 *  @param rawFrom  unevaluated string
 *  @param rawMixin unevaluated mixin object
 *
 *  @return result
 */
- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator
                       rawFrom:(NSString *__nonnull)rawFrom
                      rawMixin:(__kindof NSObject *__nonnull)rawMixin;

/**
 *  "context::key_1" to one object
 *
 *  @param operator operator
 *  @param rawFrom  unevaluated string
 *  @param rawTo unevaluated single object
 *
 *  @return result
 */
- (BOOL)evaluateCommonOperator:(NSString *__nonnull)operator
                       rawFrom:(NSString *__nonnull)rawFrom
                         rawTo:(__kindof NSObject *__nonnull)rawTo;

#pragma mark - Action

- (void)evaluateSetActionWithMixin:(__kindof NSObject *__nonnull)object
                            forKey:(NSString *__nonnull)key;

- (void)evaluateAddActionWithMixin:(__kindof NSObject *__nonnull)object
                            forKey:(NSString *__nonnull)key;

@end