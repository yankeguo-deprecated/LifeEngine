//
//  LEI18n.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEI18n.h"

#define LEI18nGroup NSDictionary<NSString*,NSString*>

NSString *const LEI18nDefaultGroupName = @"default";

@interface LEI18n ()

@property(nonatomic, strong) NSCache<NSString *, LEI18nGroup *> *cache;
@property(nonatomic, strong) NSCache<NSString *, NSString *> *directCache;

@end

@implementation LEI18n

- (instancetype)init {
  if (self = [super init]) {
    self.cache = [[NSCache alloc] init];
    self.cache.totalCostLimit = 2 * 100 * 1000;

    self.directCache = [[NSCache alloc] init];
    self.directCache.countLimit = 2 * 10 * 1000;
  }
  return self;
}

- (NSString *__nonnull)localizedStringForKey:(NSString *__nonnull)key {
  NSString *result = [self.directCache objectForKey:key];
  if (result == nil) {
    result = [self _L2_localizedStringForKey:key];
    if (result) {
      [self.directCache setObject:result forKey:key];
    }
  }
  if (result == nil) {
    result = key;
  }
  return result;
}

- (NSString *__nullable)_L2_localizedStringForKey:(NSString *__nonnull)key {
  NSString *groupName = nil;
  NSString *pathName = nil;

  NSRange dotRange = [key rangeOfString:@"."];

  if (dotRange.location == NSNotFound) {
    groupName = LEI18nDefaultGroupName;
    pathName = key;
  } else {
    groupName = [key substringToIndex:dotRange.location];
    pathName = [key substringFromIndex:dotRange.location + 1];
  }

  NSParameterAssert(groupName.length);
  NSParameterAssert(pathName.length);

  LEI18nGroup *group = [self.cache objectForKey:groupName];

  if (group == nil) {
    group = [[LEI18nGroup alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:groupName
                                                                               withExtension:@"locale.plist"]];
    NSParameterAssert(group);
    [self.cache setObject:group forKey:groupName cost:group.count];
  }

  return [group valueForKeyPath:pathName];
}

@end
