//
//  LEWaitItem.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEItem.h"

@interface LEWaitItem: LEItem

@property(nonatomic, readonly) NSTimeInterval time;

@property(nonatomic, readonly) NSString *__nonnull text;

@property(nonatomic, readonly) NSString *__nullable style;

@property(nonatomic, copy) NSString *__nullable renderedText;

@end
