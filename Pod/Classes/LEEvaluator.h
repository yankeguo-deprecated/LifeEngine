//
//  LEEvaluator.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import <Foundation/Foundation.h>

@class LEEvaluator;

@protocol LEEvaluatorDataSource

/**
 *  Resolve a string with KEY and TYPE, currently only `context` type supported
 *
 *  @param evaluator LEEvaluator
 *  @param key       key
 *  @param type      resourceType, only `context` supported
 *
 *  @return evaluation result or a empty string
 */
- (NSString *__nonnull)evaluator:(LEEvaluator *__nonnull)evaluator
             resolveStringForKey:(NSString *__nonnull)key
                    resourceType:(NSString *__nonnull)resourceType;

- (NSString *__nonnull)evaluator:(LEEvaluator *__nonnull)evaluator
    resolveLocalizedStringForKey:(NSString *__nonnull)key;

@end

@interface LEEvaluator: NSObject

/**
 *  DataSource for string evaluation
 */
@property(nonatomic, weak) id<LEEvaluatorDataSource> dataSource;

/**
 *  Evaluate a string
 *
 *  @see https://github.com/IslandZero/LifeEngine/wiki/String-Evaluation
 *
 *  @param string input
 *
 *  @return evaluation result
 */
- (NSString *__nonnull)evaluateString:(NSString *__nonnull)string;
- (NSNumber *__nonnull)evaluateStringAsNumber:(NSString *__nonnull)string;

/**
 *  Evaluate a condition dictionary
 *
 *  @see https://github.com/IslandZero/LifeEngine/wiki/Condition-Dictionary-Evaluation
 *
 *  @param dictionary condition dictionary
 *
 *  @return evaluation result
 */
- (BOOL)evaluateConditionDictionary:(NSDictionary *__nonnull)dictionary;

@end