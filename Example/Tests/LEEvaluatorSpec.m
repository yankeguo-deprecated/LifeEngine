//
//  LEEvaluatorSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/13.
//

@interface LEEvaluatorTestDataSource: NSObject<LEEvaluatorDataSource>

@end

@implementation LEEvaluatorTestDataSource

- (__kindof NSObject* __nullable)evaluator:(LEEvaluator *__nonnull)textRenderer resolveObjectForKey:(NSString *__nonnull)key resourceType:(NSString *__nonnull)type {
  return [key uppercaseString];
}

- (NSString *)evaluator:(LEEvaluator *__nonnull)textRenderer resolveLocalizedStringForKey:(NSString *__nonnull)key {
  return [key lowercaseString];
}

@end

SpecBegin(LETextRenderer)

  __block LEEvaluator *_evaluator;
  __block LEEvaluatorTestDataSource *_dataSource;


  beforeAll(^{
    _dataSource = [[LEEvaluatorTestDataSource alloc] init];
    _evaluator = [[LEEvaluator alloc] init];
    _evaluator.dataSource = _dataSource;
  });

  describe(@"context", ^{
    it(@"should work", ^{
      XCTAssertEqualObjects(@"AB C", [_evaluator evaluateString:@"A${context::b} ${context::c}"]);
    });
  });

  describe(@"i18n", ^{
    it(@"should work", ^{
      XCTAssertEqualObjects(@"ab c", [_evaluator evaluateString:@"a@{B} @{C}"]);
    });
  });

  describe(@"mixed", ^{
    it(@"should work", ^{
      XCTAssertEqualObjects(@"ABCabc", [_evaluator evaluateString:@"A${context::b}${context::c}a@{B}@{C}"]);
    });
  });

SpecEnd