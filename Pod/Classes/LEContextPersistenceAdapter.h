//
//  LEContextPersistenceAdapter.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/16.
//

#import <Foundation/Foundation.h>

@class LEContext;
@class LEContextChangeset;

@protocol LEContextPersistenceAdapter

/**
 *  Return all changesets persisted
 *
 *  @param context LEContext
 *
 *  @return all changesets
 */
- (NSArray<LEContextChangeset *> *__nonnull)allChangesetsForContext:(LEContext *__nonnull)context;

/**
 *  Invoked when a changeset is added or updated
 *
 *  @param context   LEContext
 *  @param changeset changeset added or updated
 */
- (void)context:(LEContext *__nonnull)context didAddChangeset:(LEContextChangeset *__nonnull)changeset;

/**
 *  Invoked when a changeset with rev is removed
 *
 *  @param context LEContext
 *  @param rev     rev of changeset removed
 */
- (void)context:(LEContext *__nonnull)context didRemoveChangesetWithRev:(NSUInteger)rev;

@end
