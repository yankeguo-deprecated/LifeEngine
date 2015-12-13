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

+ (instancetype)changesetWithRev:(NSUInteger)rev change:(NSDictionary *__nonnull)change {
  return [((LEContextChangeset *) [[self class] alloc]) initWithRev:rev change:change];
}

- (instancetype)initWithRev:(NSUInteger)rev change:(NSDictionary *__nonnull)change {
  change = change ?: @{};
  NSParameterAssert([change isKindOfClass:[NSDictionary class]]);
  if (self = [super init]) {
    _rev = rev;
    _change = change;
  }
  return self;
}

#pragma mark - Persistence

+ (instancetype)changesetWithDictionary:(NSDictionary *__nonnull)dictionary {
  return [self changesetWithRev:[dictionary[@"rev"] unsignedIntegerValue] change:dictionary[@"change"]];
}

- (NSDictionary *__nonnull)toDictionary {
  return @{
      @"rev" : @(self.rev),
      @"change" : self.change
  };
}

#pragma mark - Manipulation

- (instancetype)changesetByAddingObject:(__kindof NSObject *__nullable)object forKey:(NSString *__nonnull)key {
  object = object ?: [NSNull null];
  return [self changesetByAddChange:@{key : object}];
}

- (instancetype)changesetByAddChange:(NSDictionary<NSString *, __kindof NSObject *> *__nonnull)change {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self.change];
  [dictionary addEntriesFromDictionary:change];
  return [[self class] changesetWithRev:self.rev change:[dictionary copy]];
}

@end
