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

- (instancetype)initWithGame:(LEGame *__nonnull)game identifier:(NSString *__nonnull)identifier rawItems:(NSArray<NSDictionary *> *__nonnull)rawItems {
  if (self = [super init]) {
    //  hold LEGame instance
    _game = game;
    //  copy identifier
    _identifier = [identifier copy];
    //  deserialize items
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:rawItems.count];
    [rawItems enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
      [array addObject:[LEItem itemWithDictionary:obj sceneIdentifier:_identifier index:idx]];
    }];
    _items = array;
  }
  return self;
}

@end
