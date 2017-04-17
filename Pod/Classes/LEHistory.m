//
//  LEHistory.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/14.
//

#import "LEHistory.h"
#import "LEHistory+Private.h"

#import "LECache.h"

@interface LEHistory ()<LECacheDataSource>

@property(nonatomic, assign) NSUInteger numberOfEntries;

@property(nonatomic, strong) LECache<NSNumber *, LEHistoryEntry *> *cache;

@end

@implementation LEHistory

- (instancetype)init {
  if (self = [super init]) {
    self.cache = [[LECache alloc] init];
    self.cache.countLimit = 100 * 2;
  }
  return self;
}

- (void)load {
  NSParameterAssert(self.persistenceAdapter);
  self.numberOfEntries = [self.persistenceAdapter numberOfEntriesInHistory:self];
}

- (LEHistoryEntry *__nonnull)entryAtIndex:(NSUInteger)index {
  return [self.cache objectDefiniteForKey:@(index)];
}

- (void)appendEntryForItem:(__kindof LEItem *__nonnull)item withSceneIdentifier:(NSString *__nonnull)sceneIdentifier {
  LEHistoryEntry *entry = [[LEHistoryEntry alloc] init];
  entry.index = self.numberOfEntries;
  entry.item = item;
  entry.sceneIdentifier = sceneIdentifier;
  [self.persistenceAdapter history:self didAddEntry:entry];
  self.numberOfEntries = [self.persistenceAdapter numberOfEntriesInHistory:self];
}

#pragma mark - LECache DataSource

- (LEHistoryEntry *__nullable)cache:(LECache *)cache objectForKey:(NSNumber *__nonnull)key cost:(NSUInteger *_Nonnull)cost {
  *cost = 1;
  return [self.persistenceAdapter history:self entryAtIndex:key.unsignedIntegerValue];
}

@end