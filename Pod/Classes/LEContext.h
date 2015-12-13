//
//  LEContext.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEContextChangeset.h"

@class LEContext;

@protocol LEContextPersistenceDelegate

/**
 *  Return all changesets persisted
 *
 *  @param context LEContext
 *
 *  @return all changesets
 */
- (NSArray<LEContextChangeset *> *__nonnull)allChangesetsForContext:(LEContext *__nonnull)context;

/**
 *  Invoked when a changeset is added or updated
 *
 *  @param context   LEContext
 *  @param changeset changeset added or updated
 */
- (void)context:(LEContext *__nonnull)context didAddChangeset:(LEContextChangeset *__nonnull)changeset;

/**
 *  Invoked when a changeset with rev is removed
 *
 *  @param context LEContext
 *  @param rev     rev of changeset removed
 */
- (void)context:(LEContext *__nonnull)context didRemoveChangesetWithRev:(NSUInteger)rev;

@end

@interface LEContext: NSObject

/**
 *  Persistence Delegate
 */
@property(nonatomic, weak) id<LEContextPersistenceDelegate> persistenceDelegate;

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
 *  Set a NSObject for key, only NSString, NSNumber, NSNull, nil supported, will invoke persistanceDelegate
 *
 *  @param object object
 *  @param key    key for object
 *  @param rev    revision number for tracking
 */
- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object forKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

/**
 *  Remote a value for key, will invoke persistanceDelegate
 *
 *  @param key key for object
 *  @param rev revision number for tracking
 */
- (void)removeObjectForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

#pragma mark - Changesets

/**
 *  Load all changsets from persistenceDelegate
 */
- (void)load;

/**
 *  Clear all changesets and key-value pairs, will invoke persistanceDelegate
 */
- (void)clear;

/**
 *  Remove a changeset with sepcified rev, will invoke persistanceDelegate
 *
 *  @param rev rev to remove
 */
- (void)removeChangesetAtRev:(NSUInteger)rev;

/**
 *  Rollback context to current revision, will invoke persistanceDelegate
 *
 *  @param rev revision number
 */
- (void)rollbackToRev:(NSUInteger)rev;

@end