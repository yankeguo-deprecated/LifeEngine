//
//  LEHistory.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/14.
//

#import <Foundation/Foundation.h>

#import "LEItem.h"
#import "LEHistoryEntry.h"
#import "LEHistoryPersistenceAdapter.h"

@interface LEHistory: NSObject

@property(nonatomic, retain) id<LEHistoryPersistenceAdapter> __nonnull persistenceAdapter;

@property(nonatomic, readonly) NSUInteger numberOfEntries;

- (void)load;

- (LEHistoryEntry *__nonnull)entryAtIndex:(NSUInteger)index;

@end