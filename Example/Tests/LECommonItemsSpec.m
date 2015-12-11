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
    LETextItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"A" index:2];
    XCTAssertEqualObjects(item.sceneIdentifier, @"A");
    XCTAssertEqual(item.index, 2);
    XCTAssertTrue([item isKindOfClass:[LETextItem class]]);
    XCTAssertEqualObjects(item.text, @"Sample");
    XCTAssertEqualObjects(item.style, @"green");
  });
});

describe(@"LEImageItem", ^{
  it(@"should work", ^{
    NSDictionary* json = _sample[@"image"];
    LEImageItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"B" index:3];
    XCTAssertEqualObjects(item.sceneIdentifier, @"B");
    XCTAssertEqual(item.index, 3);
    XCTAssertTrue([item isKindOfClass:[LEImageItem class]]);
    XCTAssertEqualObjects(item.imageName, @"sample_image");
  });
});

describe(@"LEWaitItem", ^{
  it(@"should work with pure number", ^{
    NSDictionary* json = _sample[@"wait_number"];
    LEWaitItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"C" index:4];
    XCTAssertEqualObjects(item.sceneIdentifier, @"C");
    XCTAssertEqual(item.index, 4);
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 200);
  });
  it(@"should work with h suffix", ^{
    NSDictionary* json = _sample[@"wait_string"];
    LEWaitItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"C" index:4];
    XCTAssertEqualObjects(item.sceneIdentifier, @"C");
    XCTAssertEqual(item.index, 4);
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 1.5 * 3600);
  });
  it(@"should work with m suffix", ^{
    NSDictionary* json = _sample[@"wait_string2"];
    LEWaitItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"C" index:4];
    XCTAssertEqualObjects(item.sceneIdentifier, @"C");
    XCTAssertEqual(item.index, 4);
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 2 * 60);
  });
  it(@"should work with d suffix", ^{
    NSDictionary* json = _sample[@"wait_string3"];
    LEWaitItem* item = [LEItem itemWithDictionary:json sceneIdentifier:@"C" index:4];
    XCTAssertEqualObjects(item.sceneIdentifier, @"C");
    XCTAssertEqual(item.index, 4);
    XCTAssertTrue([item isKindOfClass:[LEWaitItem class]]);
    XCTAssertEqual(item.time, 1.5 * 3600 * 24);
  });
});

SpecEnd