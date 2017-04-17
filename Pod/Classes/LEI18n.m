//
//  LEI18n.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import "LEI18n.h"

#import "LECache.h"

#define LEI18nGroup NSDictionary<NSString*,NSString*>

NSString *const LEI18nDefaultGroupName = @"default";

@interface LEI18n ()<LECacheDataSource>

@property(nonatomic, strong) NSRegularExpression *__nonnull expressionI18n;

@property(nonatomic, strong) LECache<NSString *, LEI18nGroup *> *cache;
@property(nonatomic, strong) LECache<NSString *, NSString *> *directCache;

@end

@implementation LEI18n

- (instancetype)init {
  if (self = [super init]) {
    self.expressionI18n = [NSRegularExpression regularExpressionWithPattern:@"@\\{(.+?)\\}"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];

    self.cache = [[LECache alloc] init];
    self.cache.totalCostLimit = 2 * 100 * 1000;
    self.cache.dataSource = self;

    self.directCache = [[LECache alloc] init];
    self.directCache.countLimit = 2 * 10 * 1000;
    self.directCache.dataSource = self;
  }
  return self;
}

- (NSString *__nonnull)localizedStringForKey:(NSString *__nonnull)key {
  return [self.directCache objectDefiniteForKey:key];
}

- (NSString *__nonnull)renderString:(NSString *__nonnull)string {
  NSMutableString *result = [NSMutableString stringWithString:string];
  NSTextCheckingResult *matchResult = nil;
  while ((matchResult = [self.expressionI18n firstMatchInString:result
                                                        options:0
                                                          range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 2);
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:1]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self localizedStringForKey:key]];
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

  LEI18nGroup *group = [self.cache objectDefiniteForKey:groupName];

  return [group valueForKeyPath:pathName];
}

#pragma mark - LECache DataSource

- (id)cache:(LECache *)cache objectForKey:(NSString *__nonnull)key cost:(NSUInteger *_Nonnull)cost {
  if (cache == self.directCache) {
    *cost = 1;
    return [self _L2_localizedStringForKey:key];
  } else {
    LEI18nGroup *group = [[LEI18nGroup alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:key
                                                                               withExtension:@"locale.plist"]];
    *cost = group.count;
    return group;
  }
}

@end
