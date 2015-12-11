//
//  LEContext.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEContext.h"

@interface LEContext ()

@property(nonatomic, strong) NSMutableIndexSet *changesetRevs;
@property(nonatomic, strong) NSMutableDictionary<NSNumber *, LEContextChangeset *> *changesets;
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSObject<NSCopying, NSCoding> *> *context;

@end

@implementation LEContext

- (instancetype)init {
  if (self = [super init]) {
    self.changesetRevs = [[NSMutableIndexSet alloc] init];
    self.changesets = [[NSMutableDictionary alloc] init];
    self.context = [[NSMutableDictionary alloc] init];
  }
  return self;
}

#pragma mark - Operations

- (NSNumber *__nullable)numberFromObject:(NSObject *__nullable)object {
  if ([object isKindOfClass:[NSString class]]) {
    return @([((NSString *) object) doubleValue]);
  }
  if ([object isKindOfClass:[NSNumber class]]) {
    return (NSNumber *) object;
  }
  return nil;
}

- (NSString *__nullable)stringFromObject:(NSObject *__nullable)object {
  if ([object isKindOfClass:[NSString class]]) {
    return (NSString *) object;
  }
  if ([object isKindOfClass:[NSNumber class]]) {
    return [(NSNumber *) object stringValue];
  }
  return nil;
}

- (NSNumber *__nullable)numberForKey:(NSString *__nonnull)key {
  return [self numberFromObject:self.context[key]];
}

- (NSString *__nullable)stringForKey:(NSString *__nonnull)key {
  return [self stringFromObject:self.context[key]];
}

- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object forKey:(NSString *__nonnull)key atRev:(NSUInteger)rev {
  NSParameterAssert(![self.changesetRevs containsIndex:rev]);
  if (object == nil) object = [NSNull null];
  LEContextChangeset *changeset = [LEContextChangeset changesetWithRev:rev value:object key:key];
  [self.changesetRevs addIndex:changeset.rev];
  self.changesets[@(changeset.rev)] = changeset;
  [self reload];
}

- (void)removeValueForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev {
  [self setObject:nil forKey:key atRev:rev];
}

#pragma mark - Changesets

- (void)reload {
  [self.context removeAllObjects];

  [self.changesetRevs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    LEContextChangeset *changeset = self.changesets[@(idx)];
    if (changeset.value == nil || [changeset isKindOfClass:[NSNull class]]) {
      [self.context removeObjectForKey:changeset.key];
    } else {
      self.context[changeset.key] = [changeset.value copy];
    }
  }];
}

- (void)clear {
  [self.context removeAllObjects];
  [self.changesets removeAllObjects];
  [self.changesetRevs removeAllIndexes];
}

- (void)applyChangsets:(NSArray<LEContextChangeset *> *__nonnull)changesets {
  [changesets enumerateObjectsUsingBlock:^(LEContextChangeset *obj, NSUInteger idx, BOOL *stop) {
    NSParameterAssert(![self.changesetRevs containsIndex:obj.rev]);
    [self.changesetRevs addIndex:obj.rev];
    self.changesets[@(obj.rev)] = obj;
  }];
  [self reload];
}

@end