//
//  LESceneLoaderPersistenceAdapter.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/16.
//

#import <Foundation/Foundation.h>

@protocol LESceneLoaderPersistenceAdapter<NSObject>

- (NSDictionary *__nonnull)rawSceneWithIdentifier:(NSString *__nonnull)identifier;

@end