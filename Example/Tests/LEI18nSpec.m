//
//  LEI18nSpec.m
//  LifeExample
//
//  Created by Ryan Guo on 15/12/11.
//

SpecBegin(LEI18n)

it(@"should work with default", ^{
  LEI18n* i18n = [[LEI18n alloc] init];
  XCTAssertEqualObjects(@"Alice", [i18n localizedStringForKey:@"alice"]);
});

it(@"should work with seperated files", ^{
  LEI18n* i18n = [[LEI18n alloc] init];
  XCTAssertEqualObjects(@"Downtown", [i18n localizedStringForKey:@"addresses.downtown"]);
  XCTAssertEqualObjects(@"Downtown", [i18n localizedStringForKey:@"addresses.downtown"]);
});

it(@"should work with render text", ^{
  LEI18n* i18n = [[LEI18n alloc] init];
  XCTAssertEqualObjects(@"I'm from Downtown", [i18n renderString:@"I'm from @{addresses.downtown}"]);
});

SpecEnd