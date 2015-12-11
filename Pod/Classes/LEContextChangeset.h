//
//  LEContextChangeset.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

@interface LEContextChangeset: NSObject

/**
 *  Revision number, unsigned integer, designed to be increase-only
 */
@property(nonatomic, readonly, assign) NSUInteger rev;

/**
 *  Key for changeset
 */
@property(nonatomic, readonly, copy) NSString *__nonnull key;

/**
 *  Value for changeset, supports NSString, NSNumber, NSNull, nil only
 */
@property(nonatomic, readonly, copy) NSObject<NSCopying, NSCoding> *__nonnull value;

/**
 *  Create a new LEContextChangeset
 *
 *  @param rev   revision number
 *  @param value value
 *  @param key   key
 *
 *  @return a new instance
 */
+ (instancetype __nonnull)changesetWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key;

/**
 *  Create a new LEContextChangeset
 *
 *  @param rev   revision number
 *  @param value value
 *  @param key   key
 *
 *  @return a new instance
 */
- (instancetype __nonnull)initWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key;

@end
