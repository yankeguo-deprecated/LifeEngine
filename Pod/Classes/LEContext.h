//
//  LEContext.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEContextChangeset.h"
#import "LEContextPersistenceAdapter.h"

@interface LEContext: NSObject

/**
 *  Persistence Adapter
 */
@property(nonatomic, retain) id<LEContextPersistenceAdapter> __nonnull persistenceAdapter;

/**
 *  Get a NSObject from context
 *
 *  @param key key for value
 *
 *  @return NSString, NSNumber or nil
 */
- (__kindof NSObject *__nullable)objectForKey:(NSString *__nonnull)key;

/**
 *  Get a NSString value from context
 *
 *  @param key key for NSString value
 *
 *  @return NSString value or nil
 */
- (NSString *__nullable)stringForKey:(NSString *__nonnull)key;

/**
 *  Get a NSNumber value from context
 *
 *  @param key key for NSNumber value
 *
 *  @return NSNumber value
 */
- (NSNumber *__nullable)numberForKey:(NSString *__nonnull)key;

@end
