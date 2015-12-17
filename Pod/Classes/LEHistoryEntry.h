//
//  LEHistoryEntry.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/14.
//

#import "LESerializable.h"
#import "LEItem.h"

@interface LEHistoryEntry: LESerializable

@property(nonatomic, strong) NSString *__nonnull sceneIdentifier;

@property(nonatomic, assign) NSUInteger index;

@property(nonatomic, strong) __kindof LEItem *__nonnull item;

@end