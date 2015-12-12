//
//  LEContextPersistence.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import "LEContextPersistence.h"

NSString *const __nonnull LEContextPersistenceDirectory = @"context";

@interface LEContextPersistence ()

@property(nonatomic, strong) NSString *persistencePath;

@end

@implementation LEContextPersistence

- (instancetype)init {
  if (self = [super init]) {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask,
                                                                  YES) lastObject];
    self.persistencePath = [documentPath stringByAppendingPathComponent:LEContextPersistenceDirectory];

    [[NSFileManager defaultManager] createDirectoryAtPath:self.persistencePath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
  }
  return self;
}

- (NSString *__nonnull)persistenceFilePathForRev:(NSUInteger)rev {
  return [self.persistencePath stringByAppendingPathComponent:[NSString stringWithFormat:@"rev-%@.plist", @(rev)]];
}

- (NSArray<LEContextChangeset *> *__nonnull)allChangesetsForContext:(LEContext *__nonnull)context {
  NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.persistencePath
                                                                                   error:nil];
  NSMutableArray<LEContextChangeset *> *changesets = [[NSMutableArray alloc] initWithCapacity:files.count];
  [files enumerateObjectsUsingBlock:^(NSString *file, NSUInteger idx, BOOL *stop) {
    if ([[file pathExtension].lowercaseString isEqualToString:@"plist"]) {
      NSDictionary *dictionary =
          [NSDictionary dictionaryWithContentsOfFile:[self.persistencePath stringByAppendingPathComponent:file]];
      if (dictionary) {
        [changesets addObject:[LEContextChangeset changesetWithDictionary:dictionary]];
      } else {
        NSLog(@"Failed to load changeset: %@", file);
      }
    }
  }];
  return changesets;
}

- (void)context:(LEContext *__nonnull)context didAddChangeset:(LEContextChangeset *__nonnull)changeset {
  [[changeset toDictionary] writeToFile:[self persistenceFilePathForRev:changeset.rev]
                             atomically:YES];
}

- (void)context:(LEContext *__nonnull)context didRemoveChangesetWithRev:(NSUInteger)rev {
  [[NSFileManager defaultManager] removeItemAtPath:[self persistenceFilePathForRev:rev]
                                             error:nil];
}

@end
