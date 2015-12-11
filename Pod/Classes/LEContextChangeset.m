//
//  LEContextChangeset.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEContextChangeset.h"

@interface LEContextChangeset () {
  NSUInteger _rev;
  id<NSCopying, NSCoding> __nonnull _value;
  NSString *__nonnull _key;
}

@end

@implementation LEContextChangeset

+ (instancetype)changesetWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key {
  return [((LEContextChangeset *) [[self class] alloc]) initWithRev:rev value:value key:key];
}

- (instancetype)initWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nonnull)value key:(NSString *__nonnull)key {
  if (self = [super init]) {
    _rev = rev;
    _value = [value copy];
    _key = [key copy];
  }
  return self;
}

#pragma mark - Getters / Setters

- (NSUInteger)rev {
  return _rev;
}

- (id<NSCopying, NSCoding>)value {
  return _value;
}

- (NSString *)key {
  return _key;
}

@end
