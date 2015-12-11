//  LEContextSpec.m
//  LifeExample
//
//  Created by Ryan Guo on 15/12/11.
//

#import <Specta/Specta.h>
#import <LifeEngine/LifeEngine.h>

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

SpecEnd
