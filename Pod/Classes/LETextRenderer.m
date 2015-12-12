//
// Created by Yanke Guo on 15/12/13.
//

#import "LETextRenderer.h"

@interface LETextRenderer ()

@property(nonatomic, strong) NSRegularExpression *__nonnull expressionI18n;

@property(nonatomic, strong) NSRegularExpression *__nonnull expressionContext;

@end

@implementation LETextRenderer

- (instancetype)init {
  if (self = [super init]) {
    self.expressionI18n = [NSRegularExpression regularExpressionWithPattern:@"@\\{(.+?)\\}"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
    self.expressionContext = [NSRegularExpression regularExpressionWithPattern:@"\\$\\{(.+?)\\}"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
  }
  return self;
}

- (NSString *__nonnull)renderText:(NSString *__nonnull)text {
  NSMutableString *result = [NSMutableString stringWithString:text];
  NSTextCheckingResult *matchResult = nil;
  while ((matchResult = [self.expressionContext firstMatchInString:result
                                                           options:0
                                                             range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 2);
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:1]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self.dataSource textRenderer:self
                                        resolveContextStringForKey:key]];
  }
  while ((matchResult = [self.expressionI18n firstMatchInString:result
                                                        options:0
                                                          range:NSMakeRange(0, result.length)])) {
    NSParameterAssert(matchResult.numberOfRanges == 2);
    NSString *key = [result substringWithRange:[matchResult rangeAtIndex:1]];
    [result replaceCharactersInRange:matchResult.range
                          withString:[self.dataSource textRenderer:self
                                      resolveLocalizedStringForKey:key]];
  }
  return [result copy];
}

@end