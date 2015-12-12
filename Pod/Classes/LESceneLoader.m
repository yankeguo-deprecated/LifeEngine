//
//  LESceneLoader.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/13.
//

#import "LESceneLoader.h"

@interface LESceneLoader ()

@property(nonatomic, strong) NSCache<NSString *, NSDictionary *> *__nonnull cache;

@end

@implementation LESceneLoader

- (instancetype)init {
  if (self = [super init]) {
    self.cache = [[NSCache alloc] init];
    self.cache.totalCostLimit = 3 * 1000;
  }
  return self;
}

- (LEScene *__nonnull)sceneWithIdentifier:(NSString *__nonnull)identifier {
  NSDictionary *dictionary = [self.cache objectForKey:identifier];
  NSArray<NSDictionary *> *rawItems = nil;

  //  Resolve dictionary and rawItems
  if (dictionary == nil) {
    NSData *rawScene = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:identifier
                                                                             withExtension:@"scene.json"]];
    dictionary = [NSJSONSerialization JSONObjectWithData:rawScene options:0 error:nil];
    NSParameterAssert([dictionary isKindOfClass:[NSDictionary class]]);
    rawItems = dictionary[@"items"];
    [self.cache setObject:dictionary forKey:identifier cost:rawItems.count];
  } else {
    rawItems = dictionary[@"items"];
  }

  //  Create scene
  LEScene *scene = [[LEScene alloc] init];

  scene.identifier = [identifier copy];

  NSMutableArray<__kindof LEItem *> *items = [[NSMutableArray alloc] initWithCapacity:rawItems.count];
  [rawItems enumerateObjectsUsingBlock:^(NSDictionary *rawItem, NSUInteger index, BOOL *stop) {
    [items addObject:[LEItem itemWithDictionary:[rawItem copy]
                                sceneIdentifier:[identifier copy]
                                          index:index]];
  }];

  scene.items = items;

  return scene;
}

@end