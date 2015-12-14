//
//  LEScene.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>
#import "LEItem.h"

@interface LEScene: NSObject

@property(nonatomic, copy) NSString *__nonnull identifier;

@property(nonatomic, strong) NSArray<__kindof LEItem *> *__nonnull items;

#pragma mark - Persistence

+ (instancetype __nonnull)sceneWithDictionary:(NSDictionary *__nonnull)dictionary;

- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary;

- (NSDictionary *__nonnull)toDictionary;

@end
