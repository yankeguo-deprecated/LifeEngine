//
//  LETextItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <LifeEngine/LifeEngine.h>

@interface LETextItem: LEDisplayItem

@property(nonatomic, readonly) NSString *__nonnull text;

@property(nonatomic, readonly) NSString *__nullable style;

@property(nonatomic, copy) NSString *__nullable renderedText;

@end
