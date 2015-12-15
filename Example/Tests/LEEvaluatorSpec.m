//
//  LEEvaluatorSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/13.
//

@interface LEEvaluatorTestDataSource: NSObject<LEEvaluatorDataSource>

@property(nonatomic, strong) NSMutableDictionary *context;

@end

@implementation LEEvaluatorTestDataSource

- (instancetype)init {
  if (self = [super init]) {
    self.context = [NSMutableDictionary new];
  }
  return self;
}

- (void)clear {
  [self.context removeAllObjects];
}

- (__kindof NSObject *__nullable)evaluator:(LEEvaluator *__nonnull)textRenderer resolveObjectForKey:(NSString *__nonnull)key resourceType:(NSString *__nonnull)resourceType {
  return self.context[[NSString stringWithFormat:@"%@::%@", resourceType, key]];
}

- (NSString *)evaluator:(LEEvaluator *__nonnull)textRenderer resolveLocalizedStringForKey:(NSString *__nonnull)key {
  return [key lowercaseString];
}

- (void)evaluator:(LEEvaluator *)evaluator setObject:(__kindof NSObject *)object forKey:(NSString *)key resourceType:(NSString *)resourceType {
  self.context[[NSString stringWithFormat:@"%@::%@", resourceType, key]] = object;
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

  beforeEach(^{
    [_dataSource clear];
    [_evaluator evaluateActionDictionary:@{
        @"Set" : @{
            @"context::b" : @"bravo",
            @"context::c" : @"charle",
            @"context::bc" : @"bravo charle",

            @"context::h" : @"hello",
            @"context::w" : @"world",
            @"context::hw" : @"hello world",

            @"context::empty" : @"",

            @"context::l1" : @"1",
            @"context::l2" : @"2",
            @"context::l3" : @"3",
            @"context::l5" : @"5",

            @"context::n0" : @(0),
            @"context::n1" : @(1),
            @"context::n1.5" : @(1.5),
            @"context::n2" : @(2),
            @"context::n2.5" : @(2.5),
            @"context::n3" : @(3),
            @"context::n5" : @(5)
        }
    }];
  });

  describe(@"evaluate string", ^{
    it(@"should work with resource", ^{
      XCTAssertEqualObjects(@"hello world", [_evaluator evaluateString:@"${context::h} ${context::w}"]);
    });
    it(@"should work with i18n", ^{
      XCTAssertEqualObjects(@"ab c", [_evaluator evaluateString:@"a@{B} @{C}"]);
    });
    it(@"should work with mixed resource and i18n", ^{
      XCTAssertEqualObjects(@"hello world c", [_evaluator evaluateString:@"${context::h} ${context::w} @{C}"]);
    });
  });

  describe(@"evaluate string as number", ^{
    it(@"should work", ^{
      XCTAssertEqual(111, [_evaluator evaluateStringAsNumber:@"11${context::n1}"].integerValue);
    });
  });

  describe(@"evaluate condition", ^{
    describe(@"string", ^{

      it(@"should work with equals", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::b" : @"bravo"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::b" : @"cravo"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals and array", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::b" : @[@"bravo", @"charle"]
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals and array 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::b" : @[@"cravo", @"charle"]
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals and eval", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::bc" : @[@"B", @"${context::b} charle"]
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals and eval 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEquals" : @{
                @"context::bc" : @[@"B", @"${context::b} bharle"]
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals ignore case", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEqualsIgnoreCase" : @{
                @"context::bc" : @[@"B", @"${context::b} Charle"]
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals ignore case 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringEqualsIgnoreCase" : @{
                @"context::bc" : @[@"B", @"${context::b} bharle"]
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not equals", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotEquals" : @{
                @"context::b" : @"bravo1"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotEquals" : @{
                @"context::b" : @"bravo"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not equals ignore case", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotEqualsIgnoreCase" : @{
                @"context::b" : @"c"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not equals ignore case 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotEqualsIgnoreCase" : @{
                @"context::b" : @"BRavo"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with matches", ^{
        NSDictionary *conditionDictionary = @{
            @"StringMatches" : @{
                @"context::bc" : @"bravo ch.+?le"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with matches 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringMatches" : @{
                @"context::bc" : @"ABC.+?Q"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not matches", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotMatches" : @{
                @"context::b" : @"ba.+?o"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not matches 2", ^{
        NSDictionary *conditionDictionary = @{
            @"StringNotMatches" : @{
                @"context::b" : @"br.+?vo"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

    });


    describe(@"number", ^{
      it(@"should work with equals", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n1" : @1
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n2" : @1
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with not equals", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberNotEquals" : @{
                @"context::n2" : @1
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with not equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberNotEquals" : @{
                @"context::n2" : @2
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with equals string", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n2" : @"2"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with equals string 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n2" : @"3"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with equals eval", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n2.5" : @"${context::l2}.${context::l5}"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with equals eval 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberEquals" : @{
                @"context::n2.5" : @"${context::l2}2${context::l5}"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      //  Greater Than

      it(@"should work with greater than", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberGreaterThan" : @{
                @"context::n2" : @"1"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with greater than 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberGreaterThan" : @{
                @"context::n2" : @"2"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      //  Greater Than Equals

      it(@"should work with greater equals", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberGreaterThanEquals" : @{
                @"context::n2" : @"1"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with greater equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberGreaterThanEquals" : @{
                @"context::n2" : @"2"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
      it(@"should work with greater equals 3", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberGreaterThanEquals" : @{
                @"context::n2" : @"3"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      //  Less Than

      it(@"should work with less than", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberLessThan" : @{
                @"context::n2" : @"3"
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with less than 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberLessThan" : @{
                @"context::n2" : @"2"
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      //  Less Than Equals

      it(@"should work with less than equals", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberLessThanEquals" : @{
                @"context::n2" : @"3",
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with less than equals 2", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberLessThanEquals" : @{
                @"context::n2" : @"2",
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });

      it(@"should work with less than equals 3", ^{
        NSDictionary *conditionDictionary = @{
            @"NumberLessThanEquals" : @{
                @"context::n2" : @"1",
            }
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
    });

    describe(@"boolean", ^{
      it(@"should work with equals", ^{
        NSDictionary *conditionDictionary = @{
            @"Boolean" : @{
                @"context::h" : @YES,
                @"context::empty" : @NO,
                @"context::n2" : @YES,
                @"context::n0" : @NO,
                @"context::what" : @NO
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
    });

    describe(@"null", ^{
      it(@"should work with equals", ^{
        NSDictionary *conditionDictionary = @{
            @"Null" : @{
                @"context::aaa" : @YES,
                @"context::h" : @NO,
                @"context::n1" : @NO,
                @"context::whattt" : @YES
            }
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:conditionDictionary]);
      });
    });

    describe(@"combination", ^{
      it(@"should work", ^{
        NSDictionary *or1 = @{
            @"StringEquals" : @{@"context::h" : @[@"AAA", @"BB"]}
        };
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:or1]);
        NSDictionary *or2 = @{
            @"StringNotEquals" : @{@"context::w" : @"AAA"}
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:or2]);
        NSDictionary *or = @{
            @"Or" : @[or1, or2]
        };
        XCTAssertTrue([_evaluator evaluateConditionDictionary:or]);

        NSDictionary *not = @{@"Not" : or};
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:not]);

        NSDictionary *and1 = [or1 copy];
        NSDictionary *and2 = [or2 copy];
        NSDictionary *and = @{@"And" : @[and1, and2]};
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:and]);

        NSDictionary *orb = @{@"Or" : @[or, and]};
        XCTAssertTrue([_evaluator evaluateConditionDictionary:orb]);

        NSDictionary *notb = @{@"Not" : orb};
        XCTAssertTrue(![_evaluator evaluateConditionDictionary:notb]);
      });
    });

  });

  describe(@"evaluate action", ^{
    it(@"should work with set", ^{
      [_evaluator evaluateActionDictionary:@{
          @"Set" : @{
              @"context2::bb" : @"BB"
          }
      }];
      NSDictionary *eq = @{
          @"StringEquals" : @{@"context2::bb" : @[@"AAA", @"BB"]}
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:eq]);
    });

    it(@"should work with add", ^{
      [_evaluator evaluateActionDictionary:@{
          @"Add" : @{
              @"context::n2" : @"4"
          }
      }];
      NSDictionary *eq = @{
          @"StringEquals" : @{@"context::n2" : @[@"6"]}
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:eq]);
    });
  });

  describe(@"evaluate conditional action", ^{
    it(@"should work", ^{
      [_evaluator evaluateConditionalActionDictionary:@{
          @"If" : @{
              @"StringEquals" : @{
                  @"context::h" : @"hello"
              }
          },
          @"Do" : @{
              @"Set" : @{
                  @"context2::bb" : @"BB"
              }
          }
      }];
      NSDictionary *eq = @{
          @"StringEquals" : @{@"context2::bb" : @[@"AAA", @"BB"]}
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:eq]);
    });

    it(@"should work with multiple", ^{
      [_evaluator evaluateConditionalActionDictionaries:@[
          @{
              @"If" : @{@"StringEquals" : @{@"context::h" : @"hello 2"}},
              @"Do" : @{@"Set" : @{@"context2::bb" : @"BB"}}
          },
          @{
              @"If" : @{@"StringEquals" : @{@"context::h" : @"hello"}},
              @"Do" : @{@"Set" : @{@"context2::bb" : @"CC"}}
          }
      ]];
      NSDictionary *eq = @{
          @"StringEquals" : @{@"context2::bb" : @[@"CC"]}
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:eq]);
    });

    it(@"should work with multiple continue", ^{
      [_evaluator evaluateConditionalActionDictionaries:@[
          @{
              @"If" : @{@"StringEquals" : @{@"context::h" : @"hello"}},
              @"Do" : @{@"Set" : @{@"context2::bb" : @"BB"}},
              @"Continue" : @1
          },
          @{
              @"If" : @{@"StringEquals" : @{@"context::h" : @"hello"}},
              @"Do" : @{@"Set" : @{@"context2::bb" : @"CC"}}
          }
      ]];
      NSDictionary *eq = @{
          @"StringEquals" : @{@"context2::bb" : @[@"CC"]}
      };
      XCTAssertTrue([_evaluator evaluateConditionDictionary:eq]);
    });
  });

SpecEnd