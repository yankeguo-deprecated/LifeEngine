//
//  LEScene.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LESerializable.h"
#import "LEItem.h"

@interface LEScene: LESerializable

@property(nonatomic, copy) NSString *__nonnull identifier;

@property(nonatomic, strong) NSArray<__kindof LEItem *> *__nonnull items;

#pragma mark - Persistence

+ (instancetype __nonnull)sceneWithDictionary:(NSDictionary *__nonnull)dictionary;

@end
