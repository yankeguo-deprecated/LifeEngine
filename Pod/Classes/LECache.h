//
//  LECache.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/17.
//

#import <Foundation/Foundation.h>

@class LECache<KeyType, ObjectType>;

@protocol LECacheDataSource<NSObject>

- (id __nullable)cache:(LECache *__nonnull)cache objectForKey:(id __nonnull)key cost:(NSUInteger *__nonnull)cost;

@end

@interface LECache
<KeyType, ObjectType>: NSCache

@property(nonatomic, weak) id<LECacheDataSource> dataSource;

/**
 *  Get the object for key, if not exists, ask dataSource
 *
 *  @param key key
 *
 *  @return object
 */
- (ObjectType __nullable)objectDefiniteForKey:(KeyType __nonnull)key;

@end
