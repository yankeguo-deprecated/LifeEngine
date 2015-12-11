//
//  LEContextChangeset.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

@interface LEContextChangeset: NSObject

@property(nonatomic, readonly, assign) NSUInteger rev;

@property(nonatomic, readonly, copy) NSString *__nonnull key;

@property(nonatomic, readonly, copy) NSObject<NSCopying, NSCoding> *__nonnull value;

+ (instancetype __nonnull)changesetWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key;

- (instancetype __nonnull)initWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key;

@end
