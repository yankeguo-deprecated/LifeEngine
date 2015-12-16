//
//  LEContextPersistenceSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/14.
//

#import "LEContextDefaultPersistence.h"

SpecBegin(LEContextPersistence)

  __block LEContext *_context;
  __block LEContextDefaultPersistence *_persistence;

  beforeAll(^{
    _context = [LEContext new];
    _persistence = [LEContextDefaultPersistence new];
    _context.persistenceAdapter = _persistence;
  });

  it(@"should work with add", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context setObject:@"A" forKey:@"key1" atRev:1];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
  });

  it(@"should work with add multiple", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context setObject:@"A" forKey:@"key1" atRev:1];
    [_context setObject:@"B" forKey:@"key2" atRev:1];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key2"]);
  });

  it(@"should work with add and replace", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context setObject:@"A" forKey:@"key1" atRev:1];
    [_context setObject:@"B" forKey:@"key1" atRev:1];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key1"]);
  });

  it(@"should work with add and rev", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context setObject:@"A" forKey:@"key1" atRev:1];
    [_context setObject:@"B" forKey:@"key1" atRev:2];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key1"]);
  });

  it(@"should work with add and rev and rollback", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context setObject:@"A" forKey:@"key1" atRev:1];
    [_context setObject:@"B" forKey:@"key1" atRev:2];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key1"]);
    [context rollbackToRev:1];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
  });

  it(@"should work with add change", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context addChange:@{@"key1" : @"A", @"key2" : @"B"} atRev:1];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key2"]);
  });

  it(@"should work with add change and rev", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context addChange:@{@"key1" : @"A", @"key2" : @"B"} atRev:1];
    [_context addChange:@{@"key3" : @"D", @"key2" : @"C"} atRev:2];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
    XCTAssertEqualObjects(@"C", [context stringForKey:@"key2"]);
    XCTAssertEqualObjects(@"D", [context stringForKey:@"key3"]);
  });

  it(@"should work with add change and rev and rollback", ^{
    //  Manipulate old
    [_context load];
    [_context clear];
    [_context addChange:@{@"key1" : @"A", @"key2" : @"B"} atRev:1];
    [_context addChange:@{@"key3" : @"D", @"key2" : @"C"} atRev:2];
    //  Create new
    LEContext *context = [LEContext new];
    LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
    context.persistenceAdapter = persistence;
    [context load];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
    XCTAssertEqualObjects(@"C", [context stringForKey:@"key2"]);
    XCTAssertEqualObjects(@"D", [context stringForKey:@"key3"]);
    [context rollbackToRev:1];
    XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
    XCTAssertEqualObjects(@"B", [context stringForKey:@"key2"]);
    XCTAssertNil([context stringForKey:@"key3"]);
    {
      LEContext *context = [LEContext new];
      LEContextDefaultPersistence *persistence = [LEContextDefaultPersistence new];
      context.persistenceAdapter = persistence;
      [context load];
      XCTAssertEqualObjects(@"A", [context stringForKey:@"key1"]);
      XCTAssertEqualObjects(@"B", [context stringForKey:@"key2"]);
      XCTAssertNil([context stringForKey:@"key3"]);
    }
  });

SpecEnd