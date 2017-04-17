//
//  LESceneLoaderDefaultPersistence.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/16.
//

#import "LESceneLoaderDefaultPersistence.h"

@implementation LESceneLoaderDefaultPersistence

- (NSDictionary *__nonnull)rawSceneWithIdentifier:(NSString *__nonnull)identifier {
  NSData *rawScene = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:identifier
                                                                           withExtension:@"scene.json"]];
  return [NSJSONSerialization JSONObjectWithData:rawScene options:0 error:nil];
}

@end