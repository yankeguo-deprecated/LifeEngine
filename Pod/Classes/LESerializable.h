//
//  LESerializable.h
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/16.
//

#import <Foundation/Foundation.h>

@interface LESerializable: NSObject<NSCopying, NSCoding, NSSecureCoding>

+ (NSArray<NSDictionary *> *__nonnull)arrayOfDictionariesFromArrayOfSerializables:(NSArray<__kindof LESerializable *> *__nonnull)serializables;

+ (NSArray<__kindof LESerializable *> *__nonnull)arrayOfSerializablesFromArrayOfDictionaries:(NSArray<NSDictionary *> *__nonnull)dictionaries;

- (instancetype __nonnull)initWithDictionary:(NSDictionary *__nonnull)dictionary;

- (NSDictionary *__nonnull)toDictionary;

#pragma mark - For Subclass

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary;

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary;

@end