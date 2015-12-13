//
//  LEEvaluatorSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/13.
//

@interface LEEvaluatorTestDataSource: NSObject<LEEvaluatorDataSource>

@end

@implementation LEEvaluatorTestDataSource

- (__kindof NSObject *__nullable)evaluator:(LEEvaluator *__nonnull)textRenderer resolveObjectForKey:(NSString *__nonnull)key resourceType:(NSString *__nonnull)type {
  if ([type isEqualToString:@"context3"]) {
    return nil;
  }
  if ([type isEqualToString:@"context2"]) {
    return @([key integerValue]);
  }
  return [key uppercaseString];
}

- (NSString *)evaluator:(LEEvaluator *__nonnull)textRenderer resolveLocalizedStringForKey:(NSString *__nonnull)key {
  return [key lowercaseString];
}

@end

SpecBegin(LEEvaluator)

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

  describe(@"condition string", ^{
    it(@"should work with equals", ^{
      NSDictionary *conditionDictionary = @{
          @"StringEquals" : @{
              @"context::b" : @"B"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with equals and array", ^{
      NSDictionary *conditionDictionary = @{
          @"StringEquals" : @{
              @"context::b" : @[@"B", @"C"]
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with equals and eval", ^{
      NSDictionary *conditionDictionary = @{
          @"StringEquals" : @{
              @"context::bb" : @[@"B", @"B${context::b}"]
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });


    it(@"should work with equals ignore case", ^{
      NSDictionary *conditionDictionary = @{
          @"StringEqualsIgnoreCase" : @{
              @"context::bb" : @[@"bb", @"C${context::b}"]
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with not equals", ^{
      NSDictionary *conditionDictionary = @{
          @"StringNotEquals" : @{
              @"context::b" : @"b"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with not equals ignore case", ^{
      NSDictionary *conditionDictionary = @{
          @"StringNotEqualsIgnoreCase" : @{
              @"context::b" : @"c"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with matches", ^{
      NSDictionary *conditionDictionary = @{
          @"StringMatches" : @{
              @"context::abcdefg" : @"ABC.+?G"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with matches 2", ^{
      NSDictionary *conditionDictionary = @{
          @"StringMatches" : @{
              @"context::abcdefg" : @"ABC.+?Q"
          }
      };
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with not matches", ^{
      NSDictionary *conditionDictionary = @{
          @"StringNotMatches" : @{
              @"context::abcdefg" : @"ABC.+?G"
          }
      };
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

    it(@"should work with not matches 2", ^{
      NSDictionary *conditionDictionary = @{
          @"StringNotMatches" : @{
              @"context::abcdefg" : @"ABC.+?Q"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });

  });

  describe(@"condition number", ^{
    it(@"should work with equals", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberEquals" : @{
              @"context2::111" : @111
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with not equals", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberNotEquals" : @{
              @"context2::111" : @112
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with not equals 2", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberNotEquals" : @{
              @"context2::111" : @111
          }
      };
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with equals string", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberEquals" : @{
              @"context2::111" : @"111"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with equals eval", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberEquals" : @{
              @"context2::111" : @"${context2::111}"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with greater than", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberGreaterThan" : @{
              @"context2::112" : @"111"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with greater equals", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberGreaterThanEquals" : @{
              @"context2::112" : @"112"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with greater equals 2", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberGreaterThanEquals" : @{
              @"context2::111" : @"112"
          }
      };
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with less than", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberLessThan" : @{
              @"context2::112" : @"113"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with less than equals", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberLessThanEquals" : @{
              @"context2::112" : @"113",
              @"context2::112" : @"112"
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work with less than equals 2", ^{
      NSDictionary *conditionDictionary = @{
          @"NumberLessThanEquals" : @{
              @"context2::112" : @"112",
              @"context2::111" : @"110"
          }
      };
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
  });

  describe(@"condition boolean", ^{
    it(@"should work with equals", ^{
      NSDictionary *conditionDictionary = @{
          @"Boolean" : @{
              @"context2::111" : @YES,
              @"context2::0" : @NO,
              @"context::a" : @YES,
              @"context::" : @NO
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
  });

  describe(@"condition null", ^{
    it(@"should work with equals", ^{
      NSDictionary *conditionDictionary = @{
          @"Null" : @{
              @"context3::111" : @YES,
              @"context2::0" : @NO,
              @"context3::a" : @YES,
              @"context::" : @NO
          }
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
  });

  describe(@"condition complex", ^{
    it(@"should work 1", ^{
      NSDictionary *conditionDictionary = @{
          @"Or" : @[
              @{
                  @"StringEquals" : @{@"context::aaa" : @[@"AAA", @"BB"]}
              },
              @{
                  @"StringNotEquals" : @{@"context::aaa" : @"AAA"}
              }
          ]
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work 2", ^{
      NSDictionary *conditionDictionary = @{
          @"Not" : @{
              @"Or" : @[
                  @{
                      @"StringEquals" : @{@"context::aaa" : @[@"AAA", @"BB"]}
                  },
                  @{
                      @"StringNotEquals" : @{@"context::aaa" : @"AAA"}
                  }
              ]
          }};
      XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
    it(@"should work 3", ^{
      NSDictionary *conditionDictionary = @{
          @"Not" : @{
              @"And" : @[
                  @{
                      @"StringEquals" : @{@"context::aaa" : @[@"AAA", @"BB"]}
                  },
                  @{
                      @"StringNotEquals" : @{@"context::aaa" : @"AAA"}
                  }
              ]
          }};
      XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
    });
  });

SpecEnd