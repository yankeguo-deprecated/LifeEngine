//
//  LEContextChangeset.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LESerializable.h"

@interface LEContextChangeset: LESerializable

/**
 *  Revision number, unsigned integer, designed to be increase-only
 */
@property(nonatomic, readonly, assign) NSUInteger rev;

/**
 *  Change in Dictionary representation, NSNull, NSNumber, NSString can be used
 */
@property(nonatomic, readonly, strong) NSDictionary<NSString *, __kindof NSObject *> *__nonnull change;

/**
 *  Create a new LEContextChangeset from NSDictionary
 *
 *  @param dictionary dictionary with 'rev', 'change'
 *
 *  @return a new instance
 */
+ (instancetype __nonnull)changesetWithDictionary:(NSDictionary *__nonnull)dictionary;

/**
 *  Create a new LEContextChangeset
 *
 *  @param rev   revision number
 *  @param change dictionary of change
 *
 *  @return a new instance
 */
+ (instancetype __nonnull)changesetWithRev:(NSUInteger)rev change:(NSDictionary *__nonnull)change;

/**
 *  Create a new LEContextChangeset
 *
 *  @param rev   revision number
 *  @param change dictionary of change
 *
 *  @return a new instance
 */
- (instancetype __nonnull)initWithRev:(NSUInteger)rev change:(NSDictionary *__nonnull)change;

#pragma mark - Manipulation

/**
 *  Create a new changeset with new object for key added
 *
 *  @param object object, only NSString, NSString, NSNull supported
 *  @param key    key
 *
 *  @return new instance
 */
- (instancetype __nonnull)changesetByAddingObject:(__kindof NSObject *__nullable)object
                                           forKey:(NSString *__nonnull)key;

/**
 *  Create a new changeset with new change added
 *
 *  @param change change dictionary, only NSString, NSNumber, NSNull supported
 *
 *  @return new instance
 */
- (instancetype __nonnull)changesetByAddChange:(NSDictionary<NSString *, __kindof NSObject *> *__nonnull)change;

@end
