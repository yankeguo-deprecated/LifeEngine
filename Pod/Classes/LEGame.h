//
//  LEGame.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEI18n.h"
#import "LEItem.h"
#import "LEScene.h"
#import "LESceneLoader.h"
#import "LEEvaluator.h"
#import "LEHistory.h"
#import "LEContextPersistenceAdapter.h"
#import "LESceneLoaderPersistenceAdapter.h"

@class LEGame;

@protocol LEGameUIDelegate<NSObject>

- (void)game:(LEGame *__nonnull)game presentItem:(LEItem *__nonnull)item;

@end

@interface LEGame: NSObject

@property(nonatomic, weak) id<LEGameUIDelegate> __nullable uiDelegate;

@property(nonatomic, readonly) LEI18n *__nonnull i18n;

@property(nonatomic, readonly) LESceneLoader *__nonnull sceneLoader;

@property(nonatomic, readonly) LEContext *__nonnull context;

@property(nonatomic, readonly) LEEvaluator *__nonnull evaluator;

@property(nonatomic, readonly) LEHistory *__nonnull history;

@property(nonatomic, readonly) LEScene *__nonnull currentScene;

@property(nonatomic, readonly) __kindof LEItem *__nonnull currentItem;

#pragma mark - LifeCycle

- (void)load;

#pragma mark - Context

- (void)setContextObject:(__kindof NSObject *__nullable)object forKey:(NSString *__nonnull)key;

#pragma mark - Game Control

- (void)handleInput:(NSString *__nonnull)input;

- (BOOL)advanceTowardNextItem;

- (BOOL)advanceTowardNextItemAfter:(NSTimeInterval)time;

@end
