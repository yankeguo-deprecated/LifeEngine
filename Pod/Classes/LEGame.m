//
//  LEGame.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEGame.h"

@interface LEGame ()<LETextRendererDataSource>

@end

@implementation LEGame

- (instancetype)init {
  if (self = [super init]) {
    _i18n = [[LEI18n alloc] init];
    _context = [[LEContext alloc] init];
    _textRenderer = [[LETextRenderer alloc] init];
    _textRenderer.dataSource = self;
  }
  return self;
}

#pragma mark - TextRendererDataSource

- (NSString *__nonnull)textRenderer:(LETextRenderer *__nonnull)textRenderer
         resolveContextStringForKey:(NSString *__nonnull)key {
  return [self.context stringForKey:key] ?: @"";
}

- (NSString *__nonnull)textRenderer:(LETextRenderer *__nonnull)textRenderer
       resolveLocalizedStringForKey:(NSString *__nonnull)key {
  return [self.i18n localizedStringForKey:key] ?: @"";
}

@end
