//
//  LEInputItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/17.
//

#import "LEInputItem.h"
#import "LEGame.h"

@interface LEInputItem ()

@property(nonatomic, strong) NSString *__nonnull key;

@end

@implementation LEInputItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  self.key = dictionary[@"key"];
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"key"] = self.key;
}

- (void)game:(LEGame *__nonnull)game handleInput:(NSString *__nonnull)input {
  [super game:game handleInput:input];

  [game setContextObject:input forKey:self.key];
  [game advanceTowardNextItem];
}

@end