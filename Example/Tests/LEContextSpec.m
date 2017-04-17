//  LEContextSpec.m
//  LifeExample
//
//  Created by Ryan Guo on 15/12/11.
//

#import <LifeEngine/LEContext+Private.h>

SpecBegin(LEContext)

describe(@"stringForKey", ^{
  
  it(@"should work with NSString", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@"A" forKey:@"key" atRev:1];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key"]);
  });
  
  it(@"should work with NSNumber", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqualObjects(@"1", [context stringForKey:@"key"]);
  });
  
  it(@"should work with nil", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqualObjects(@"1", [context stringForKey:@"key"]);
    [context setObject:nil forKey:@"key" atRev:2];
    XCTAssertTrue([context stringForKey:@"key"] == nil);
  });
  
});

describe(@"numberForKey", ^{
  it(@"should work with NSString", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@"1" forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
  });
  
  it(@"should work with NSNumber", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
  });
  
  it(@"should work with nil", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
    [context setObject:nil forKey:@"key" atRev:2];
    XCTAssertTrue([context stringForKey:@"key"] == nil);
  });
});

describe(@"setObjectForKeyAtRev", ^{
  it(@"should work with multiple times", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
    [context setObject:@(2) forKey:@"key" atRev:2];
    XCTAssertEqual(2, [context numberForKey:@"key"].integerValue);
    [context setObject:@"C" forKey:@"key" atRev:3];
    XCTAssertEqualObjects(@"C", [context stringForKey:@"key"]);
  });
});

describe(@"removeForKeyAtRev", ^{
  it(@"should work", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
    [context removeObjectForKey:@"key" atRev:2];
    XCTAssertTrue([context stringForKey:@"key"] == nil);
  });
});

describe(@"rollbackToRev", ^{
  it(@"should work", ^{
    LEContext* context = [[LEContext alloc] init];
    [context setObject:@(1) forKey:@"key" atRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
    [context setObject:@(2) forKey:@"key" atRev:2];
    XCTAssertEqual(2, [context numberForKey:@"key"].integerValue);
    [context setObject:@"C" forKey:@"key" atRev:3];
    XCTAssertEqualObjects(@"C", [context stringForKey:@"key"]);
    [context rollbackToRev:2];
    XCTAssertEqual(2, [context numberForKey:@"key"].integerValue);
    [context rollbackToRev:1];
    XCTAssertEqual(1, [context numberForKey:@"key"].integerValue);
  });
});

SpecEnd
