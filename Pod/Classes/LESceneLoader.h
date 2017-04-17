//
//  LESceneLoader.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import <Foundation/Foundation.h>

#import "LEScene.h"
#import "LESceneLoaderPersistenceAdapter.h"

@interface LESceneLoader: NSObject

@property(nonatomic, retain) id<LESceneLoaderPersistenceAdapter> __nonnull persistenceAdapter;

- (LEScene *__nonnull)sceneWithIdentifier:(NSString *__nonnull)identifier;

@end
