//
//  LESceneLoader.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import <Foundation/Foundation.h>

#import "LEScene.h"

@interface LESceneLoader: NSObject

- (LEScene* __nonnull)sceneWithIdentifier:(NSString* __nonnull)identifier;

@end
