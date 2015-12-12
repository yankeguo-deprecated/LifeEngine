//
//  LEImageItem.m
//  Pods
//
//  Created by Yanke Guo on 15/12/11.
//
//

#import "LEImageItem.h"

@interface LEImageItem ()

@end

@implementation LEImageItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  _imageName = dictionary[@"image_name"];
  NSParameterAssert(_imageName);
}

- (void)dumpToDictionary:(NSMutableDictionary *__nonnull)dictionary {
  [super dumpToDictionary:dictionary];

  dictionary[@"image_name"] = self.imageName;
}

@end
