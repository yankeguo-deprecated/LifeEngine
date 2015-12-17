//
//  LEViewController.m
//  LifeEngine
//
//  Created by Ryan Guo on 12/11/2015.
//  Copyright (c) 2015 Ryan Guo. All rights reserved.
//

#import "LEViewController.h"

#import <LifeEngine/LifeEngine.h>
#import <LifeEngine/LEContextDefaultPersistence.h>
#import <LifeEngine/LESceneLoaderDefaultPersistence.h>
#import <LifeEngine/LEHistoryDefaultPersistence.h>

@interface LEViewController ()<LEGameUIDelegate>

@property(nonatomic, strong) LEGame *game;

@end

@implementation LEViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.game = [LEGame new];

  self.game.uiDelegate = self;
  self.game.context.persistenceAdapter = [LEContextDefaultPersistence new];
  self.game.sceneLoader.persistenceAdapter = [LESceneLoaderDefaultPersistence new];
  self.game.history.persistenceAdapter = [LEHistoryDefaultPersistence new];
  [self.game load];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)game:(LEGame *__nonnull)game presentItem:(LEItem *__nonnull)item {
}

@end
