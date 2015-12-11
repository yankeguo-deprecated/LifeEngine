//
//  LEItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEItem.h"

@interface LEItem () {
  NSString *_sceneIdentifier;
  NSUInteger _index;
}

@end

@implementation LEItem

+ (__kindof LEItem *__nonnull)itemWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index {
  NSString *clsName = (NSString *) dictionary[@"__class"];
  if (clsName == nil) {
    clsName = @"LETextItem";
  }
  NSParameterAssert([clsName isKindOfClass:[NSString class]]);
  LEItem *item = [((LEItem *) [NSClassFromString(clsName) alloc]) initWithDictionary:dictionary
                                                                     sceneIdentifier:sceneIdentifier
                                                                               index:index];
  return item;
}

- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary sceneIdentifier:(NSString *__nonnull)sceneIdentifier index:(NSUInteger)index {
  if (self = [super init]) {
    _sceneIdentifier = [sceneIdentifier copy];
    _index = index;
    [self awakeFromDictionary:dictionary];
  }
  return self;
}

#pragma mark - Getters / Setters

- (NSString *)sceneIdentifier {
  return _sceneIdentifier;
}

- (NSUInteger)index {
  return _index;
}

#pragma mark - For Subclass

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
}

@end
