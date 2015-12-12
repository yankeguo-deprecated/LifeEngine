//
//  LEScene.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>
#import "LEItem.h"

@class LEGame;

@interface LEScene: NSObject

@property(nonatomic, copy) NSString *__nonnull identifier;

@property(nonatomic, strong) NSArray<__kindof LEItem *> *__nonnull items;

@end
