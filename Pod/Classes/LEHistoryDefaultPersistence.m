//
//  LEHistoryDefaultPersistence.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/17.
//

#import "LEHistoryDefaultPersistence.h"

NSString *const __nonnull LEHistoryPersistenceDirectory = @"history";

@interface LEHistoryDefaultPersistence ()

@property(nonatomic, strong) NSString *persistencePath;

@end

@implementation LEHistoryDefaultPersistence

- (instancetype)init {
  if (self = [super init]) {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask,
                                                                  YES) lastObject];
    self.persistencePath = [documentPath stringByAppendingPathComponent:LEHistoryPersistenceDirectory];

    [[NSFileManager defaultManager] createDirectoryAtPath:self.persistencePath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
  }
  return self;
}

- (NSString *__nonnull)filePathForIndex:(NSUInteger)index {
  return [self.persistencePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.history.json", @(index)]];
}

- (NSUInteger)numberOfEntriesInHistory:(LEHistory *__nonnull)history {
  NSArray *allFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.persistencePath error:nil];
  __block NSUInteger count = 0;
  [allFiles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
    if ([obj hasSuffix:@".history.json"]) {
      count++;
    }
  }];
  return count;
}

- (LEHistoryEntry *__nonnull)history:(LEHistory *__nonnull)history entryAtIndex:(NSUInteger)index {
  NSData *data = [NSData dataWithContentsOfFile:[self filePathForIndex:index]];
  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  return [[LEHistoryEntry alloc] initWithDictionary:dictionary];
}

- (void)history:(LEHistory *__nonnull)history didAddEntry:(LEHistoryEntry *__nonnull)entry {
  NSUInteger index = entry.index;
  NSDictionary *dictionary = [entry toDictionary];
  NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
  [data writeToFile:[self filePathForIndex:index] atomically:YES];
}

@end