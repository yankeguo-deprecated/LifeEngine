//
//  LETextRendererSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/13.
//

@interface LETextRendererTestDataSource : NSObject<LETextRendererDataSource>

@end

@implementation LETextRendererTestDataSource

- (NSString *)textRenderer:(LETextRenderer *)textRenderer resolveContextStringForKey:(NSString *)key {
  return [key uppercaseString];
}

- (NSString *)textRenderer:(LETextRenderer *)textRenderer resolveLocalizedStringForKey:(NSString *)key {
  return [key lowercaseString];
}

@end

SpecBegin(LETextRenderer)

__block LETextRenderer* _renderer;
__block LETextRendererTestDataSource* _dataSource;


beforeAll(^{
  _dataSource = [[LETextRendererTestDataSource alloc] init];
  _renderer   = [[LETextRenderer alloc]  init];
  _renderer.dataSource = _dataSource;
});

describe(@"context", ^{
  it(@"should work", ^{
    XCTAssertEqualObjects(@"AB C", [_renderer renderText:@"A${b} ${c}"]);
  });
});

describe(@"i18n", ^{
  it(@"should work", ^{
    XCTAssertEqualObjects(@"ab c", [_renderer renderText:@"a@{B} @{C}"]);
  });
});

describe(@"mixed", ^{
  it(@"should work", ^{
    XCTAssertEqualObjects(@"ABCabc", [_renderer renderText:@"A${b}${c}a@{B}@{C}"]);
  });
});

SpecEnd