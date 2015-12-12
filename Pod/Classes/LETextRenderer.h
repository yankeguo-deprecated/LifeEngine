//
//  LETextRenderer.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import <Foundation/Foundation.h>

@class LETextRenderer;

@protocol LETextRendererDataSource

- (NSString *__nonnull)textRenderer:(LETextRenderer *__nonnull)textRenderer
         resolveContextStringForKey:(NSString *__nonnull)key;

- (NSString *__nonnull)textRenderer:(LETextRenderer *__nonnull)textRenderer
       resolveLocalizedStringForKey:(NSString *__nonnull)key;

@end

@interface LETextRenderer: NSObject

/**
 *  DataSource for text replacing
 */
@property(nonatomic, weak) id<LETextRendererDataSource> dataSource;

/**
 *  Render a text
 *
 *  @see https://github.com/IslandZero/LifeEngine/wiki/Text-Rendering
 *
 *  @param text text input
 *
 *  @return rendered text
 */
- (NSString *__nonnull)renderText:(NSString *__nonnull)text;

@end