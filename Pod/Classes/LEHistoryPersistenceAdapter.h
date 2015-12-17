//
//  LEHistoryPersistenceAdapter.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/17.
//

#import <Foundation/Foundation.h>

#import "LEHistoryEntry.h"

@class LEHistory;

@protocol LEHistoryPersistenceAdapter<NSObject>

- (NSUInteger)numberOfEntriesInHistory:(LEHistory *__nonnull)history;

- (LEHistoryEntry *__nonnull)history:(LEHistory *__nonnull)history entryAtIndex:(NSUInteger)index;

- (void)history:(LEHistory *__nonnull)history didAddEntry:(LEHistoryEntry *__nonnull)entry;

@end