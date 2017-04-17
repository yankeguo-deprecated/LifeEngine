//
//  LEContext.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEContext.h"

#import "LEContext+Private.h"

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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter numberFromString:(NSString *) object];
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

- (__kindof NSObject *__nullable)objectForKey:(NSString *__nonnull)key {
  NSObject *value = self.context[key];
  if ([value isKindOfClass:[NSNull class]] || value == nil) {
    return nil;
  }
  return value;
}

- (NSString *__nullable)stringForKey:(NSString *__nonnull)key {
  return [self stringFromObject:self.context[key]];
}

- (void)setObject:(NSObject<NSCopying, NSCoding> *__nullable)object forKey:(NSString *__nonnull)key atRev:(NSUInteger)rev {
  if (object == nil) object = [NSNull null];
  //  Reuse existing changeset or create a new one
  LEContextChangeset *changeset = self.changesets[@(rev)];
  if (changeset) {
    changeset = [changeset changesetByAddingObject:object forKey:key];
  } else {
    changeset = [LEContextChangeset changesetWithRev:rev change:@{key : object}];
  }
  //  Update
  [self.changesetRevs addIndex:changeset.rev];
  self.changesets[@(changeset.rev)] = changeset;
  //  Persistence
  [self.persistenceAdapter context:self didAddChangeset:changeset];
  //  Rebuild
  [self rebuild];
}

- (void)addChange:(NSDictionary *__nonnull)change atRev:(NSUInteger)rev {
  //  Reuse existing changeset or create a new one
  LEContextChangeset *changeset = self.changesets[@(rev)];
  if (changeset) {
    changeset = [changeset changesetByAddChange:change];
  } else {
    changeset = [LEContextChangeset changesetWithRev:rev change:change];
  }
  //  Update
  [self.changesetRevs addIndex:changeset.rev];
  self.changesets[@(changeset.rev)] = changeset;
  //  Persistence
  [self.persistenceAdapter context:self didAddChangeset:changeset];
  //  Rebuild
  [self rebuild];
}

- (void)removeObjectForKey:(NSString *__nonnull)key atRev:(NSUInteger)rev {
  [self setObject:nil forKey:key atRev:rev];
}

#pragma mark - Changesets

- (void)rebuild {
  [self.context removeAllObjects];

  [self.changesetRevs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    LEContextChangeset *changeset = self.changesets[@(idx)];
    [changeset.change enumerateKeysAndObjectsUsingBlock:^(NSString *key, __kindof NSObject *obj, BOOL *stop2) {
      self.context[key] = obj;
    }];
  }];
}

- (void)load {
  NSParameterAssert(self.persistenceAdapter != nil);
  //  Update
  NSArray *changesets = [self.persistenceAdapter allChangesetsForContext:self];
  [changesets enumerateObjectsUsingBlock:^(LEContextChangeset *changeset, NSUInteger idx, BOOL *stop) {
    [self.changesetRevs addIndex:changeset.rev];
    self.changesets[@(changeset.rev)] = changeset;
  }];
  //  Rebuild
  [self rebuild];
}

- (void)clear {
  //  Persistence
  [self.changesetRevs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    [self.persistenceAdapter context:self didRemoveChangesetWithRev:idx];
  }];
  //  Update
  [self.context removeAllObjects];
  [self.changesets removeAllObjects];
  [self.changesetRevs removeAllIndexes];
}

- (void)removeChangesetAtRev:(NSUInteger)rev {
  //  Update
  [self.changesetRevs removeIndex:rev];
  [self.changesets removeObjectForKey:@(rev)];
  //  Persistence
  [self.persistenceAdapter context:self didRemoveChangesetWithRev:rev];
  //  Rebuild
  [self rebuild];
}

- (void)rollbackToRev:(NSUInteger)rev {
  //  Update
  NSUInteger revToRevmoe = NSNotFound;;
  while ((revToRevmoe = [self.changesetRevs indexGreaterThanIndex:rev]) != NSNotFound) {
    [self.changesetRevs removeIndex:revToRevmoe];
    [self.changesets removeObjectForKey:@(revToRevmoe)];
    //  Persistence
    [self.persistenceAdapter context:self didRemoveChangesetWithRev:revToRevmoe];
  }
  //  Rebuild
  [self rebuild];
}

@end