//
//  LEGame.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

#import "LEI18n.h"
#import "LEContext.h"
#import "LEEvaluator.h"

@interface LEGame: NSObject

@property(nonatomic, readonly) LEI18n *__nonnull i18n;

@property(nonatomic, readonly) LEContext *__nonnull context;

@property(nonatomic, readonly) LEEvaluator *__nonnull evaluator;

#pragma mark - Game Control

- (BOOL)advanceTowardNextItem;

- (BOOL)advanceTowardNextItemAfter:(NSTimeInterval)time;

@end
