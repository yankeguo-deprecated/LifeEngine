//
//  LEContextDefaultPersistence.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import "LEContextDefaultPersistence.h"

#import "LEContextChangeset.h"

NSString *const __nonnull LEContextPersistenceDirectory = @"context";

@interface LEContextDefaultPersistence ()

@property(nonatomic, strong) NSString *persistencePath;

@end

@implementation LEContextDefaultPersistence

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
  return [self.persistencePath stringByAppendingPathComponent:[NSString stringWithFormat:@"rev-%@.json", @(rev)]];
}

- (NSArray<LEContextChangeset *> *__nonnull)allChangesetsForContext:(LEContext *__nonnull)context {
  NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.persistencePath
                                                                                   error:nil];
  NSMutableArray *changesets = [[NSMutableArray alloc] initWithCapacity:files.count];
  [files enumerateObjectsUsingBlock:^(NSString *file, NSUInteger idx, BOOL *stop) {
    if ([[file pathExtension].lowercaseString isEqualToString:@"json"]) {
      NSData *data = [NSData dataWithContentsOfFile:[self.persistencePath stringByAppendingPathComponent:file]];
      if (data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
          [changesets addObject:[LEContextChangeset changesetWithDictionary:dictionary]];
        } else {
          NSLog(@"Failed to load %@ as dictionary", file);
        }
      } else {
        NSLog(@"Failed to load %@ as data", file);
      }
    }
  }];
  return changesets;
}

- (void)context:(LEContext *__nonnull)context didAddChangeset:(LEContextChangeset *__nonnull)changeset {
  NSData *data = [NSJSONSerialization dataWithJSONObject:[changeset toDictionary] options:0 error:nil];
  if (data) {
    [data writeToFile:[self persistenceFilePathForRev:changeset.rev] atomically:YES];
  } else {
    NSLog(@"cannot generate persistence file for changeset %@", changeset);
  }
}

- (void)context:(LEContext *__nonnull)context didRemoveChangesetWithRev:(NSUInteger)rev {
  [[NSFileManager defaultManager] removeItemAtPath:[self persistenceFilePathForRev:rev]
                                             error:nil];
}

@end
