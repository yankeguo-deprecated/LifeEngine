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

- (void)didDisplayInGame:(LEGame *__nonnull)game;

- (void)handleInput:(NSString *__nonnull)input inGame:(LEGame *__nonnull)game;

@end
