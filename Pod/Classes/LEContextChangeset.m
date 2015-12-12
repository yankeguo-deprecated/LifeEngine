//
//  LEContextChangeset.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEContextChangeset.h"

@interface LEContextChangeset ()

@end

@implementation LEContextChangeset

+ (instancetype)changesetWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nullable)value key:(NSString *__nonnull)key {
  return [((LEContextChangeset *) [[self class] alloc]) initWithRev:rev value:value key:key];
}

+ (instancetype)changesetWithDictionary:(NSDictionary *__nonnull)dictionary {
  return [self changesetWithRev:[dictionary[@"rev"] unsignedIntegerValue]
                          value:dictionary[@"value"]
                            key:dictionary[@"key"]];
}

- (instancetype)initWithRev:(NSUInteger)rev value:(NSObject<NSCopying, NSCoding> *__nullable)value key:(NSString *__nonnull)key {
  NSParameterAssert(key != nil);
  if (value == nil) value = [NSNull null];
  if (self = [super init]) {
    _rev = rev;
    _value = [value copy];
    _key = [key copy];
  }
  return self;
}

- (NSDictionary *__nonnull)toDictionary {
  if ([self.value isKindOfClass:[NSNull class]]) {
    return @{
        @"rev" : @(self.rev),
        @"key" : self.key,
    };
  } else {
    return @{
        @"rev" : @(self.rev),
        @"key" : self.key,
        @"value" : self.value
    };
  }
}

@end
