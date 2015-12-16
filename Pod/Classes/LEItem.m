//
//  LEItem.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEItem.h"

NSString *const __nonnull LEItemClassKey = @"class";

NSDictionary *__nonnull LEItemBuiltinClassShortcuts;

@interface LEItem ()

@end

@implementation LEItem

+ (void)initialize {
  [super initialize];

  if (self == [LEItem class]) {
    LEItemBuiltinClassShortcuts = @{
        @"text" : @"LETextItem",
        @"image" : @"LEImageItem",
        @"wait" : @"LEWaitItem",
        @"option" : @"LEOptionItem"
    };
  }
}

+ (__kindof LEItem *__nonnull)itemWithDictionary:(NSDictionary *__nonnull)dictionary {
  return [((__kindof LEItem *) [[self class] alloc]) initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *__nonnull)dictionary {
  NSString *clsName = (NSString *) dictionary[LEItemClassKey];
  if (clsName == nil) { clsName = @"text"; }
  NSParameterAssert([clsName isKindOfClass:[NSString class]]);
  Class targetCls = NSClassFromString(LEItemBuiltinClassShortcuts[clsName]) ?: NSClassFromString(clsName);
  NSParameterAssert(targetCls != NULL);

  if ([self class] != targetCls && [self class] == [LEItem class]) {
    LEItem *item = [((LEItem *) [targetCls alloc]) initWithDictionary:dictionary];
    NSParameterAssert([item isKindOfClass:[LEItem class]]);
    self = item;
  } else {
    self = [super initWithDictionary:dictionary];
  }

  return self;
}

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[LEItemClassKey] = NSStringFromClass([self class]);
}

#pragma mark - For Subclass

- (void)didDisplayInGame:(LEGame *__nonnull)game {
}

- (void)handleInput:(NSString *__nonnull)input inGame:(LEGame *__nonnull)game {
}

@end
