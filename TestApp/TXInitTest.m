//
//  TXInitTest.m
//  TestApp
//
//  Created by Jeff Davis on 3/18/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXInitTest.h"

@interface TXWidget : NSObject {
    NSInteger _foo;
}
- (void)doSomething;
@end

@implementation TXWidget

- (id)init {
    if (NO) {
        if (self = [super init]) {
            _foo = 123;
        }
    }
    return self;
}

- (void)dealloc {
    NSLog(@"TXWidget: dealloc");
    [super dealloc];
}

- (void)doSomething {
    NSLog(@"Something: %@", self);
}

- (NSString*)description {
    return [NSString stringWithFormat:@"TXWidget: self = %p <%@>, foo = %d", self, [self class], _foo];
}

@end

@implementation TXInitTest

- (void)doTest {
    TXWidget* widget = [[TXWidget alloc] init];
    NSLog(@"Created a TXWidget: %@", widget);
    [widget doSomething];
    [widget release];
    widget = nil;
}

@end
