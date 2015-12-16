//
//  LEOptionItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEOptionItem.h"
#import "LEGame.h"

@implementation LEOptionItemOption

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  _identifier = dictionary[@"id"];
  _text = dictionary[@"text"];
  _renderedText = dictionary[@"rendered_text"];

  _actions = dictionary[@"action"];

  //  Resolve Mixin
  if ([_actions isKindOfClass:[NSDictionary class]]) {
    _actions = @[(NSDictionary *) _actions];
  }
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"id"] = self.identifier;
  dictionary[@"text"] = self.text;
  dictionary[@"rendered_text"] = self.renderedText;
  dictionary[@"action"] = self.actions;
}

@end

@implementation LEOptionItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  NSArray <NSDictionary *> *rawOptions = dictionary[@"options"];
  NSParameterAssert([rawOptions isKindOfClass:[NSArray class]] && rawOptions.count == 2);
  self.options = [LEOptionItemOption arrayOfSerializablesFromArrayOfDictionaries:rawOptions];
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"options"] = [LEOptionItemOption arrayOfDictionariesFromArrayOfSerializables:self.options];
}

- (void)handleInput:(NSString *__nonnull)input inGame:(LEGame *__nonnull)game {
  [super handleInput:input inGame:game];

  [self.options enumerateObjectsUsingBlock:^(LEOptionItemOption *obj, NSUInteger idx, BOOL *stop) {
    if ([obj.identifier isEqualToString:input]) {
      [game.evaluator evaluateConditionalActionDictionaries:obj.actions];
    }
  }];
}

@end
