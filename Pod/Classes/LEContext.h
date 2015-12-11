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

- (NSString *__nullable)stringForKey:(NSString *__nonnull)key;

- (NSNumber *__nullable)numberForKey:(NSString *__nonnull)key;

- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object forKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

- (void)removeValueForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev;

#pragma mark - Changesets

- (void)reload;

- (void)clear;

- (void)applyChangsets:(NSArray<LEContextChangeset *> *__nonnull)changesets;

- (void)rollbackToRev:(NSUInteger)rev;

@end