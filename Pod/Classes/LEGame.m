//
//  LEGame.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEGame.h"

#import "LEEvaluator.h"
#import "LEI18n.h"
#import "LEContext+Private.h"
#import "LEHistory+Private.h"
#import "LESceneLoader.h"

@interface LEGame ()<LEEvaluatorDataSource>

@property(nonatomic, strong) LESceneLoader *__nonnull sceneLoader;

@property(nonatomic, strong) LEI18n *__nonnull i18n;

@property(nonatomic, strong) LEContext *__nonnull context;

@property(nonatomic, strong) LEEvaluator *__nonnull evaluator;

@end

@implementation LEGame

- (instancetype)init {
  if (self = [super init]) {
    self.i18n = [[LEI18n alloc] init];

    self.context = [[LEContext alloc] init];

    self.sceneLoader = [[LESceneLoader alloc] init];

    self.evaluator = [[LEEvaluator alloc] init];
    self.evaluator.dataSource = self;
  }
  return self;
}

#pragma mark - LifeCycle

- (void)load {
  NSParameterAssert(self.sceneLoader.persistenceAdapter != nil);
  [self.context load];
  [self.history load];
}

#pragma mark - Context

- (void)setContextObject:(__kindof NSObject *__nullable)object forKey:(NSString *__nonnull)key {
  [self.context setObject:object forKey:key atRev:self.history.numberOfEntries];
}

#pragma mark - TextRendererDataSource

- (__kindof NSObject *__nullable)evaluator:(LEEvaluator *__nonnull)evaluator
                       resolveObjectForKey:(NSString *__nonnull)key
                              resourceType:(NSString *__nonnull)type {
  //  Currently we support context only
  NSParameterAssert([type isEqualToString:@"context"]);
  return [self.context objectForKey:key];
}

- (void)evaluator:(LEEvaluator *__nonnull)evaluator
        setObject:(__kindof NSObject *__nonnull)object
           forKey:(NSString *__nonnull)key
     resourceType:(NSString *__nonnull)resourceType {
  //  Currently we support context only
  NSParameterAssert([resourceType isEqualToString:@"context"]);
  [self setContextObject:object forKey:key];
}

- (NSString *__nonnull)evaluator:(LEEvaluator *__nonnull)evaluator renderStringWithI18n:(NSString *__nonnull)string {
  return [self.i18n renderString:string];
}

#pragma mark - Game Flow

- (void)handleInput:(NSString *__nonnull)input {
  [self.currentItem game:self handleInput:input];
}

- (BOOL)advanceTowardNextItem {
  return NO;
}

- (BOOL)advanceTowardNextItemAfter:(NSTimeInterval)time {
  return NO;
}

@end
