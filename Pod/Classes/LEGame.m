//
//  LEGame.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEGame.h"

#import "LEEvaluator.h"
#import "LEI18n.h"
#import "LEContext.h"
#import "LEContextPersistence.h"
#import "LESceneLoader.h"

@interface LEGame ()<LEEvaluatorDataSource>

@property(nonatomic, readonly) LESceneLoader *__nonnull sceneLoader;

@property(nonatomic, readonly) LEContextPersistence *__nonnull contextPersistence;

@end

@implementation LEGame

- (instancetype)init {
  if (self = [super init]) {
    _i18n = [[LEI18n alloc] init];

    _context = [[LEContext alloc] init];
    _contextPersistence = [[LEContextPersistence alloc] init];
    _context.persistenceDelegate = self.contextPersistence;

    _sceneLoader = [[LESceneLoader alloc] init];

    _evaluator = [[LEEvaluator alloc] init];
    _evaluator.dataSource = self;
  }
  return self;
}

#pragma mark - TextRendererDataSource

- (__kindof NSObject *__nullable)evaluator:(LEEvaluator *__nonnull)evaluator
                       resolveObjectForKey:(NSString *__nonnull)key
                              resourceType:(NSString *__nonnull)type {
  //  Currently we support context only
  NSParameterAssert([type isEqualToString:@"context"]);
  return [self.context objectForKey:key];
}

- (NSString *__nonnull)evaluator:(LEEvaluator *__nonnull)evaluator
    resolveLocalizedStringForKey:(NSString *__nonnull)key {
  return [self.i18n localizedStringForKey:key] ?: @"";
}

- (void)evaluator:(LEEvaluator *__nonnull)evaluator
        setObject:(__kindof NSObject *__nonnull)object
           forKey:(NSString *__nonnull)key
     resourceType:(NSString *__nonnull)resourceType {
}

@end
