//
//  LEItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

extern NSString *const __nonnull LEItemClassKey;

@interface LEItem: NSObject<NSCopying>

@property(nonatomic, readonly) NSString *__nonnull sceneIdentifier;

@property(nonatomic, readonly, assign) NSUInteger index;

+ (__kindof LEItem *__nonnull)itemWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index;

- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index;

- (NSDictionary *__nonnull)toDictionary;

#pragma mark - For Subclass

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary;

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary;

@end
