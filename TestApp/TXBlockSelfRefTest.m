//
//  TXBlockSelfRefTest.m
//  TestApp
//
//  Created by Jeff Davis on 5/14/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXBlockSelfRefTest.h"

#import <UIKit/UIKit.h>

typedef void (^TXFunc)();

@interface TXFoo : NSObject {
    TXFunc _func;
}
- (void)setFunc:(TXFunc)func;
@end

@implementation TXFoo

- (id)init {
    if (self = [super init]) {
        NSLog(@"[TXFoo init]");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"[TXFoo dealloc]");
    if (_func) Block_release(_func);
    [super dealloc];
}

- (void)setFunc:(TXFunc)func {
    NSLog(@"[TXFoo setFunc]");
    if (_func) Block_release(_func);
    if (func) _func = Block_copy(func);
}

@end

@interface TXBlockSelfRefTest () {
    TXFoo* _foo;
}

@property(nonatomic,assign) BOOL bar;

@end

@implementation TXBlockSelfRefTest

@synthesize bar = _bar;

- (id)init {
    if (self = [super init]) {
        NSLog(@"[TXBlockSelfRefTest init]");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"[TXBlockSelfRefTest dealloc]");
    [_foo release];
    [super dealloc];
}

- (void)setBar:(BOOL)bar {
    _bar = bar;
}

- (void)doTest {
    NSLog(@"[TXBlockSelfRefTest doTest]");

    UIAlertView* view = [[[UIAlertView alloc] initWithTitle:@"Leak?"
                                                    message:@"Shall I leak or do it right?"
                                                   delegate:self
                                          cancelButtonTitle:@"Leak"
                                          otherButtonTitles:@"Do it right", nil] autorelease];
    [view show];

    // Keep a ref on ourselves so we stay alive until the user makes a choice.
    [self retain];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {

        // In this example the block will do an implict retain on self.  Note self holds a retained reference to _foo,
        // which holds a retained reference to the block so we have created a circular reference that is never broken.
        _foo = [[TXFoo alloc] init];
        [_foo setFunc:^{
            self.bar = YES;
        }];

    } else {

        // This example creates a weak reference to self for use in the block.  This allows proper destruction, but runs
        // the risk of crashing if self becomes deallocated and the block is later invoked.
        _foo = [[TXFoo alloc] init];
        __block TXBlockSelfRefTest* weak = self;
        [_foo setFunc:^{
            weak.bar = YES;
        }];

    }

    // Release the ref on ourself from doTest.  We should begin the dealloc process at this point.
    [self release];
}

@end
