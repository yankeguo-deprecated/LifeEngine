//
//  LESerializable.m
//  LifeEngine
//
//  Created by Ryan Guo on 15/12/16.
//

#import "LESerializable.h"

@implementation LESerializable

+ (NSArray<NSDictionary *> *__nonnull)arrayOfDictionariesFromArrayOfSerializables:(NSArray<__kindof LESerializable *> *__nonnull)serializables {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:serializables.count];
  [serializables enumerateObjectsUsingBlock:^(__kindof LESerializable *obj, NSUInteger idx, BOOL *stop) {
    [array addObject:[obj toDictionary]];
  }];
  return array;
}

+ (NSArray<__kindof LESerializable *> *__nonnull)arrayOfSerializablesFromArrayOfDictionaries:(NSArray<NSDictionary *> *__nonnull)dictionaries {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:dictionaries.count];
  [dictionaries enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
    [array addObject:[((__kindof LESerializable *) [[self class] alloc]) initWithDictionary:obj]];
  }];
  return array;
}

- (instancetype)initWithDictionary:(NSDictionary *__nonnull)dictionary {
  if (self = [super init]) {
    [self awakeFromDictionary:dictionary];
  }
  return self;
}

- (NSDictionary *__nonnull)toDictionary {
  NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
  [self dumpToDictionary:dictionary];
  return dictionary;
}

#pragma mark - NSCopy

- (id)copyWithZone:(NSZone *)zone {
  return [((__kindof LESerializable *) [[self class] alloc]) initWithDictionary:[self toDictionary]];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:[self toDictionary] forKey:@"dict"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  return [self initWithDictionary:[coder decodeObjectOfClass:[NSDictionary class] forKey:@"dict"]];
}

+ (BOOL)supportsSecureCoding {
  return YES;
}

#pragma mark - For Subclass

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary { }

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary { }

@end