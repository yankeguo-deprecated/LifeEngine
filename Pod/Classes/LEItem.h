//
//  LEItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LESerializable.h"

@class LEGame;

extern NSString *const __nonnull LEItemClassKey;

@interface LEItem: LESerializable

+ (__kindof LEItem *__nonnull)itemWithDictionary:(NSDictionary *__nonnull)dictionary;

#pragma mark - For Subclass

- (void)willPresent:(LEGame *__nonnull)game;

- (void)didPresent:(LEGame *__nonnull)game;

- (void)willMoveToHistory:(LEGame *__nonnull)game;

- (void)didMoveToHistory:(LEGame *__nonnull)game;

- (void)game:(LEGame *__nonnull)game handleInput:(NSString *__nonnull)input;

@end
