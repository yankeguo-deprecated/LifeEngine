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

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  _text = dictionary[@"text"];
  _style = dictionary[@"style"];
  _renderedText = dictionary[@"rendered_text"];
  NSParameterAssert(_text);
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"text"] = self.text;
  dictionary[@"style"] = self.style;
  dictionary[@"rendered_text"] = self.renderedText;
}

- (void)didPresent:(LEGame *__nonnull)game {
  [game advanceTowardNextItem];
}

@end
