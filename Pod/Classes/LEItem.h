//
//  LEItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

@interface LEItem: NSObject

@property(nonatomic, readonly) NSString *__nonnull sceneIdentifier;

@property(nonatomic, readonly, assign) NSUInteger index;

+ (__kindof LEItem *__nonnull)itemWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index;

- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index;

#pragma mark - For Subclass

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary;

@end
