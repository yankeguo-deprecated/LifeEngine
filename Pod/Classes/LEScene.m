//
//  LEScene.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEScene.h"

#import "LEGame.h"

@interface LEScene ()

@end

@implementation LEScene

+ (instancetype)sceneWithDictionary:(NSDictionary *__nonnull)dictionary {
  return [((LEScene *) [[self class] alloc]) initWithDictionary:dictionary];
}

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  self.identifier = dictionary[@"id"];
  NSParameterAssert([self.identifier isKindOfClass:[NSString class]]);
  
  self.next = dictionary[@"next"];

  NSArray<NSDictionary *> *rawItems = dictionary[@"items"];
  NSParameterAssert([rawItems isKindOfClass:[NSArray class]]);
  self.items = [LEItem arrayOfSerializablesFromArrayOfDictionaries:rawItems];
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"id"] = self.identifier;
  dictionary[@"next"] = self.next;
  dictionary[@"items"] = [LEItem arrayOfDictionariesFromArrayOfSerializables:self.items];
}

@end
