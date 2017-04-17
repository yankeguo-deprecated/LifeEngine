//
//  LEWaitItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEWaitItem.h"
#import "LEGame.h"

@interface LEWaitItem ()

@end

@implementation LEWaitItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  //  Extract Time

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

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"time"] = @(self.time);
}

#pragma mark - DidDisplay

- (void)didPresent:(LEGame *__nonnull)game {
  [super didPresent:game];

  [game advanceTowardNextItemAfter:self.time];
}

@end
