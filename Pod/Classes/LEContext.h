//
//  LEContext.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEContextChangeset.h"

@interface LEContext: NSObject

#pragma mark - Operations

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
 *  Set a NSObject for key, only NSString, NSNumber, NSNull, nil supported
 *
 *  @param object object
 *  @param key    key for object
 *  @param rev    revision number for tracking
 */
- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object forKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

/**
 *  Remote a value for key
 *
 *  @param key key for object
 *  @param rev revision number for tracking
 */
- (void)removeObjectForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

#pragma mark - Changesets

/**
 *  Reload context and rebuild key-value pairs from changesets
 */
- (void)reload;

/**
 *  Clear all changesets and key-value pairs
 */
- (void)clear;

/**
 *  Apply a array of changesets
 *
 *  @param changesets changesets to apply
 */
- (void)applyChangsets:(NSArray<LEContextChangeset *> *__nonnull)changesets;

/**
 *  Rollback context to current revision
 *
 *  @param rev revision number
 */
- (void)rollbackToRev:(NSUInteger)rev;

@end