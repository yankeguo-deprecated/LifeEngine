//
//  LEGame.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEItem.h"
#import "LEEvaluator.h"
#import "LEContextPersistenceAdapter.h"
#import "LESceneLoaderPersistenceAdapter.h"

@class LEGame;

@protocol LEGameUIDelegate<NSObject>

- (void)game:(LEGame *__nonnull)game presentItem:(LEItem *__nonnull)item;

@end

@interface LEGame: NSObject

@property(nonatomic, weak) id<LEGameUIDelegate> __nullable uiDelegate;

@property(nonatomic, readwrite) id<LEContextPersistenceAdapter> __nonnull contextPersistenceAdapter;

@property(nonatomic, readwrite) id<LESceneLoaderPersistenceAdapter> __nonnull sceneLoaderPersistenceAdapter;

@property(nonatomic, readonly) LEEvaluator * __nonnull evaluator;

#pragma mark - LifeCycle

- (void)load;

#pragma mark - History Query

- (NSUInteger)numberOfHistoryItems;

- (LEItem *__nonnull)historyItemAtIndex:(NSUInteger)index;

#pragma mark - Game Control

- (void)handleInput:(NSString *__nonnull)input;

- (BOOL)advanceTowardNextItem;

- (BOOL)advanceTowardNextItemAfter:(NSTimeInterval)time;

@end
