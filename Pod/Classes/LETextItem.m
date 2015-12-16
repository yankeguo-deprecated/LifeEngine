//
//  LETextItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LETextItem.h"
#import "LEGame.h"

@interface LETextItem ()

@end

@implementation LETextItem

- (void)didPresent:(LEGame *__nonnull)game {
  [super didPresent:game];

  [game advanceTowardNextItem];
}

@end
