//
//  LECommonItemsSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/12.
//

SpecBegin(LECommonItems)

__block NSDictionary* _sample;

beforeAll(^{
  NSData* sampleData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"items_sample" withExtension:@"json"]];
  _sample = [NSJSONSerialization JSONObjectWithData:sampleData options:0 error:nil];
});

describe(@"LETextItem", ^{
  it(@"should work", ^{
    NSDictionary* json = _sample[@"text"];
    LETextItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LETextItem class]]);
    XCTAssertEqualObjects(item.text, @"Sample");
    XCTAssertEqualObjects(item.style, @"green");
  });
  it(@"should work with dump", ^{
    NSDictionary* json = _sample[@"text"];
    LETextItem* item = [LEItem itemWithDictionary:json];
    item = [LEItem itemWithDictionary:[item toDictionary]];
    XCTAssertTrue([item isKindOfClass:[LETextItem class]]);
    XCTAssertEqualObjects(item.text, @"Sample");
    XCTAssertEqualObjects(item.style, @"green");
  });
  it(@"should work with prerendered text", ^{
    NSDictionary* json = _sample[@"text_pre_rendered"];
    LETextItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LETextItem class]]);
    XCTAssertEqualObjects(item.text, @"Sample");
    XCTAssertEqualObjects(item.renderedText, @"Sample2");
    XCTAssertEqualObjects(item.style, @"green");
  });
});

describe(@"LEImageItem", ^{
  it(@"should work", ^{
    NSDictionary* json = _sample[@"image"];
    LEImageItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LEImageItem class]]);
    XCTAssertEqualObjects(item.imageName, @"sample_image");
  });
  it(@"should work with dump", ^{
    NSDictionary* json = _sample[@"image"];
    LEImageItem* item = [LEItem itemWithDictionary:json];
    item = [LEItem itemWithDictionary:[item toDictionary]];
    XCTAssertTrue([item isKindOfClass:[LEImageItem class]]);
    XCTAssertEqualObjects(item.imageName, @"sample_image");
  });
});

describe(@"LEWaitItem", ^{
  it(@"should work with pure number", ^{
    NSDictionary* json = _sample[@"wait_number"];
    LEWaitItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 200);
  });
  it(@"should work with dump", ^{
    NSDictionary* json = _sample[@"wait_number"];
    LEWaitItem* item = [LEItem itemWithDictionary:json];
    item = [LEItem itemWithDictionary:[item toDictionary]];
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 200);
  });
  it(@"should work with h suffix", ^{
    NSDictionary* json = _sample[@"wait_string"];
    LEWaitItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 1.5 * 3600);
  });
  it(@"should work with m suffix", ^{
    NSDictionary* json = _sample[@"wait_string2"];
    LEWaitItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 2 * 60);
  });
  it(@"should work with d suffix", ^{
    NSDictionary* json = _sample[@"wait_string3"];
    LEWaitItem* item = [LEItem itemWithDictionary:json];
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 1.5 * 3600 * 24);
  });
});

SpecEnd