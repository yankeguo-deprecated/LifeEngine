//
//  LECache.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/17.
//

#import "LECache.h"

@implementation LECache

- (id)objectDefiniteForKey:(id __nonnull)key {
  id object = [super objectForKey:key];
  if (object == nil) {
    NSUInteger cost = 0;
    object = [self.dataSource cache:self objectForKey:key cost:&cost];
    if (object) {
      [self setObject:object forKey:key cost:cost];
    }
  }
  return object;
}

@end
