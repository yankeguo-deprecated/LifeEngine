//
//  LEWaitItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEWaitItem.h"

@interface LEWaitItem () {
  NSTimeInterval _time;
}

@end

@implementation LEWaitItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  NSString *number = dictionary[@"time"];

  _time = [number doubleValue];

  if ([number isKindOfClass:[NSString class]]) {
    if ([number hasSuffix:@"h"]) {
      _time = _time * 3600;
    } else if ([number hasSuffix:@"m"]) {
      _time = _time * 60;
    } else if ([number hasSuffix:@"d"]) {
      _time = _time * 3600 * 24;
    }
  }

  NSParameterAssert(_time > 0);
}

- (NSTimeInterval)time {
  return _time;
}

@end
