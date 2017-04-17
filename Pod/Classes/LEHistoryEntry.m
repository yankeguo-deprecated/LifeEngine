//
//  LEHistoryEntry.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/14.
//

#import "LEHistoryEntry.h"

@implementation LEHistoryEntry

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  self.item = [[LEItem alloc] initWithDictionary:dictionary[@"item"]];
  self.sceneIdentifier = dictionary[@"scene_identifier"];
  self.index = [dictionary[@"index"] unsignedIntegerValue];
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"item"] = [self.item toDictionary];
  dictionary[@"index"] = @(self.index);
  dictionary[@"scene_identifier"] = self.sceneIdentifier;
}

@end