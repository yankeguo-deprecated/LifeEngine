//
//  LEImageItem.m
//  Pods
//
//  Created by Yanke Guo on 15/12/11.
//
//

#import "LEImageItem.h"

@interface LEImageItem () {
  NSString *__nonnull _imageName;
}

@end

@implementation LEImageItem

- (void)awakeFromDictionary:(NSDictionary *__nonnull)dictionary {
  [super awakeFromDictionary:dictionary];

  _imageName = [dictionary[@"image_name"] copy];
  NSParameterAssert(_imageName);
}

@end
