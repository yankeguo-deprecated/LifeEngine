//
//  LEI18n.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Foundation/Foundation.h>

extern NSString * __nonnull const LEI18nDefaultGroupName;

@interface LEI18n: NSObject

/**
 *  Get localized string from key
 *
 *  @param key key
 *
 *  @return localized string
 */
- (NSString *__nullable)localizedStringForKey:(NSString *__nonnull)key;

@end
