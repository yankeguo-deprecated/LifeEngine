//
//  LEHistory.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/14.
//

#import "LEHistory.h"
#import "LEHistory+Private.h"

@interface LEHistory ()

@property(nonatomic, assign) NSUInteger numberOfEntries;

@property(nonatomic, strong) NSCache<NSNumber *, LEHistoryEntry *> *cache;

@end

@implementation LEHistory

- (instancetype)init {
  if (self = [super init]) {
    self.cache = [[NSCache alloc] init];
    self.cache.countLimit = 100 * 2;
  }
  return self;
}

- (void)load {
  NSParameterAssert(self.persistenceAdapter);
  self.numberOfEntries = [self.persistenceAdapter numberOfEntriesInHistory:self];
}

- (LEHistoryEntry *__nonnull)entryAtIndex:(NSUInteger)index {
  LEHistoryEntry *entry = [self.cache objectForKey:@(index)];
  if (entry == nil) {
    entry = [self.persistenceAdapter history:self entryAtIndex:index];
    if (entry) {
      [self.cache setObject:entry forKey:@(index)];
    }
  }
  return entry;
}

- (void)appendEntryForItem:(__kindof LEItem *__nonnull)item withSceneIdentifier:(NSString *__nonnull)sceneIdentifier {
  LEHistoryEntry *entry = [[LEHistoryEntry alloc] init];
  entry.index = self.numberOfEntries;
  entry.item = item;
  entry.sceneIdentifier = sceneIdentifier;
  [self.persistenceAdapter history:self didAddEntry:entry];
  self.numberOfEntries = [self.persistenceAdapter numberOfEntriesInHistory:self];
}

@end