//
//  LEScene.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>
#import "LEItem.h"

@class LEGame;

@interface LEScene: NSObject

@property(nonatomic, readonly) LEGame *__nonnull game;

@property(nonatomic, readonly) NSString *__nonnull identifier;

@property(nonatomic, readonly) NSArray<__kindof LEItem *> *__nonnull items;

- (instancetype __nonnull)initWithGame:(LEGame *__nonnull)game
                            identifier:(NSString *__nonnull)identifier
                              rawItems:(NSArray<NSDictionary *> *__nonnull)rawItems;

@end
