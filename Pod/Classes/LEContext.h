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

#pragma mark - Operations

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

/**
 *  Set a NSObject for key, only NSString, NSNumber, NSNull, nil supported, will invoke persistenceDelegate
 *
 *  @param object object
 *  @param key    key for object
 *  @param rev    revision number for tracking
 */
- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object
           forKey:(NSString *__nonnull)key
            atRev:(NSUInteger)rev;

/**
 *  Add change from dictionary at rev
 *
 *  @param change change dictionary, contains NSString, NSNumber, NSNull only
 *  @param rev    rev
 */
- (void)addChange:(NSDictionary<NSString *, __kindof NSObject *> *__nonnull)change atRev:(NSUInteger)rev;

/**
 *  Remote a value for key, will invoke persistenceDelegate
 *
 *  @param key key for object
 *  @param rev revision number for tracking
 */
- (void)removeObjectForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

#pragma mark - Changesets

/**
 *  Load all changsets from persistenceAdapter
 */
- (void)load;

/**
 *  Clear all changesets and key-value pairs, will invoke persistenceDelegate
 */
- (void)clear;

/**
 *  Remove a changeset with sepcified rev, will invoke persistenceDelegate
 *
 *  @param rev rev to remove
 */
- (void)removeChangesetAtRev:(NSUInteger)rev;

/**
 *  Rollback context to current revision, will invoke persistenceDelegate
 *
 *  @param rev revision number
 */
- (void)rollbackToRev:(NSUInteger)rev;

@end