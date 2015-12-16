//
//  LEOptionItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEItem.h"

@interface LEOptionItemOption: LESerializable

@property(nonatomic, copy, readonly) NSString *__nonnull identifier;

@property(nonatomic, copy, readonly) NSString *__nonnull text;

@property(nonatomic, copy) NSString *__nullable renderedText;

@property(nonatomic, strong, readonly) NSArray< NSDictionary *> *__nonnull actions;

@end

@interface LEOptionItem: LEItem

@property(nonatomic, strong) NSArray<LEOptionItemOption *> *__nonnull options;

@end
