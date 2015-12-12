//
//  LESceneLoaderSpec.m
//  LifeEngineExample
//
//  Created by Ryan Guo on 15/12/13.
//

SpecBegin(LESceneLoader)

  it(@"should work", ^{
    LESceneLoader *loader = [[LESceneLoader alloc] init];
    LEScene *scene = [loader sceneWithIdentifier:@"sample"];
    XCTAssertEqual(scene.items.count, 2);
    LETextItem *textItem = scene.items[0];
    XCTAssertTrue([textItem isKindOfClass:[LETextItem class]]);
    XCTAssertEqualObjects(textItem.text, @"@{alice} is here");
    LEImageItem *imageItem = scene.items[1];
    XCTAssertTrue([imageItem isKindOfClass:[LEImageItem class]]);
    XCTAssertEqualObjects(imageItem.imageName, @"sample_scene");
  });

SpecEnd