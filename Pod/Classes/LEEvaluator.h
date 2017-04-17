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
 *  @return object for key
 */
- (__kindof NSObject *__nullable)evaluator:(LEEvaluator *__nonnull)evaluator
                       resolveObjectForKey:(NSString *__nonnull)key
                              resourceType:(NSString *__nonnull)resourceType;

- (NSString *__nonnull)evaluator:(LEEvaluator *__nonnull)evaluator
            renderStringWithI18n:(NSString *__nonnull)string;

/**
 *  Set a object for key with resourceType, basically for context set
 *
 *  @param evaluator    LEEvaluator
 *  @param object       object, NSNumber, NSString or NSNull
 *  @param key          key
 *  @param resourceType resourceType
 */
- (void)evaluator:(LEEvaluator *__nonnull)evaluator
        setObject:(__kindof NSObject *__nonnull)object
           forKey:(NSString *__nonnull)key
     resourceType:(NSString *__nonnull)resourceType;

@end

@interface LEEvaluator: NSObject

/**
 *  DataSource for string evaluation
 */
@property(nonatomic, weak) id<LEEvaluatorDataSource> dataSource;

- (__kindof NSObject *__nullable)resolveObjectForKey:(NSString *__nonnull)key
                                        resourceType:(NSString *__nonnull)resourceType;

- (NSString *__nonnull)resolveObjectAsStringForKey:(NSString *__nonnull)key
                                      resourceType:(NSString *__nonnull)resourceType;

- (NSNumber *__nonnull)resolveObjectAsNumberForKey:(NSString *__nonnull)key
                                      resourceType:(NSString *__nonnull)resourceType;

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

/**
 *  Evaluate a action dictionary
 *
 *  @see https://github.com/IslandZero/LifeEngine/wiki/Action-Dictionary
 *
 *  @param action action dictionary
 */
- (void)evaluateActionDictionary:(NSDictionary *__nonnull)action;
- (void)evaluateActionDictionaries:(NSArray<NSDictionary *> *__nonnull)actions;

/**
 *  Evaluate a condictional dictionary
 *
 *  @see https://github.com/IslandZero/LifeEngine/wiki/Conditional-Action-Dictionary
 *
 *  @param conditionalActions conditionalActions, NSArray of dictionary
 */
- (void)evaluateConditionalActionDictionary:(NSDictionary *__nonnull)conditionalAction;
- (void)evaluateConditionalActionDictionaries:(NSArray<NSDictionary *> *__nonnull)conditionalActions;

@end