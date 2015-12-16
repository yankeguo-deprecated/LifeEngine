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

- (instancetype)initWithDictionary:(NSDictionary *__nonnull)dictionary {
  if (self = [super init]) {
    self.identifier = dictionary[@"id"];
    NSParameterAssert([self.identifier isKindOfClass:[NSString class]]);

    NSArray<NSDictionary *> *rawItems = dictionary[@"items"];
    NSParameterAssert([rawItems isKindOfClass:[NSArray class]]);
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:rawItems.count];
    [rawItems enumerateObjectsUsingBlock:^(NSDictionary *rawItem, NSUInteger idx, BOOL *stop) {
      NSParameterAssert([rawItem isKindOfClass:[NSDictionary class]]);
      [items addObject:[LEItem itemWithDictionary:rawItem sceneIdentifier:self.identifier index:idx]];
    }];
    self.items = items;
  }
  return self;
}

- (NSDictionary *__nonnull)toDictionary {
  NSMutableArray *rawItems = [[NSMutableArray alloc] initWithCapacity:self.items.count];
  [self.items enumerateObjectsUsingBlock:^(__kindof LEItem *item, NSUInteger idx, BOOL *stop) {
    [rawItems addObject:[item toDictionary]];
  }];
  return @{@"id" : self.identifier, @"items" : rawItems};
}

@end
