//
//  LEContext+Private.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEContext.h"

@interface LEContext ()

/**
 *  Load all changsets from persistenceAdapter
 */
- (void)load;

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
