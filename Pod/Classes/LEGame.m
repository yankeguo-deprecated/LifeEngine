//
//  LEGame.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEGame.h"

#import "LETextRenderer.h"
#import "LEI18n.h"
#import "LEContext.h"
#import "LEContextPersistence.h"
#import "LESceneLoader.h"

@interface LEGame ()<LETextRendererDataSource>

@property(nonatomic, readonly) LEI18n *__nonnull i18n;

@property(nonatomic, readonly) LEContext *__nonnull context;

@property(nonatomic, readonly) LETextRenderer *__nonnull textRenderer;

@property(nonatomic, readonly) LESceneLoader *__nonnull sceneLoader;

@property(nonatomic, readonly) LEContextPersistence *__nonnull contextPersistence;

@end

@implementation LEGame

- (instancetype)init {
  if (self = [super init]) {
    _i18n = [[LEI18n alloc] init];

    _context = [[LEContext alloc] init];
    _contextPersistence = [[LEContextPersistence alloc] init];
    _context.persistenceDelegate = self.contextPersistence;

    _sceneLoader = [[LESceneLoader alloc] init];

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
