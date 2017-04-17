//
//  LEBaseTextItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEBaseTextItem.h"
#import "LEGame.h"
#import "LEI18n.h"

@interface LEBaseTextItem ()

@end

@implementation LEBaseTextItem

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

- (void)willPresent:(LEGame *__nonnull)game {
  [super willPresent:game];

  self.renderedText = [game.i18n renderString:self.text];
  self.renderedText = [game.evaluator evaluateString:self.renderedText];
}

@end
