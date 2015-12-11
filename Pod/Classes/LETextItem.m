//
//  LETextItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LETextItem.h"

@interface LETextItem () {
  NSString *__nullable _style;
  NSString *__nonnull _text;
}

@end

@implementation LETextItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  _text = dictionary[@"text"];
  _style = dictionary[@"style"];
  NSParameterAssert(_text);
}

#pragma mark - Getters / Setters

- (NSString *)text {
  return _text;
}

- (NSString *)style {
  return _style;
}

@end
