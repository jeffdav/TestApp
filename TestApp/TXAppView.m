//
//  TXAppView.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXAppView.h"

#import "UIView+Hierarchy.h"

#include "TXInlineFun.h"

#import "TXArrayPerfTest.h"
#import "TXBlockSelfRefTest.h"
#import "TXClassObjectTest.h"
#import "TXInitTest.h"
#import "TXStringSortTest.h"

@interface TXAppView () {
  @private
    UIButton* _classObjectTestButton;
    UIButton* _arrayPerfTestButton;
    UIButton* _sortConcurrencyTestButton;
    UIButton* _initTestButton;
    UIButton* _blockSelfRefButton;
}
-(void)initButtons;
-(void)classObjectTest:(id)sender;
-(void)arrayPerfTest:(id)sender;
-(void)sortConcurrencyPerfTest:(id)sender;
-(void)initTest:(id)sender;
@end

@implementation TXAppView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
      
        [self initButtons];
        [self testConspectus];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat y = 20;

    [_classObjectTestButton sizeToFit];
    CGRect frame = _classObjectTestButton.frame;
    frame.origin = CGPointMake(10, y);
    _classObjectTestButton.frame = frame;
    y += CGRectGetHeight(frame) + 10;

    [_arrayPerfTestButton sizeToFit];
    frame = _arrayPerfTestButton.frame;
    frame.origin = CGPointMake(10, y);
    _arrayPerfTestButton.frame = frame;
    y += CGRectGetHeight(frame) + 10;
    
    [_sortConcurrencyTestButton sizeToFit];
    frame = _sortConcurrencyTestButton.frame;
    frame.origin = CGPointMake(10, y);
    _sortConcurrencyTestButton.frame = frame;
    y += CGRectGetHeight(frame) + 10;

    [_initTestButton sizeToFit];
    frame = _initTestButton.frame;
    frame.origin = CGPointMake(10, y);
    _initTestButton.frame = frame;
    y += CGRectGetHeight(frame) + 10;

    [_blockSelfRefButton sizeToFit];
    frame = _blockSelfRefButton.frame;
    frame.origin = CGPointMake(10, y);
    _blockSelfRefButton.frame = frame;
    y += CGRectGetHeight(frame) + 10;
}

#pragma mark Internal

- (void)initButtons {
    _classObjectTestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_classObjectTestButton setTitle:@"Class Object Test" forState:UIControlStateNormal];
    [_classObjectTestButton addTarget:self action:@selector(classObjectTest:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_classObjectTestButton];

    _arrayPerfTestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_arrayPerfTestButton setTitle:@"Array Perf Test" forState:UIControlStateNormal];
    [_arrayPerfTestButton addTarget:self action:@selector(arrayPerfTest:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_arrayPerfTestButton];
    
    _sortConcurrencyTestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sortConcurrencyTestButton setTitle:@"Concurrent Sort Perf Test" forState:UIControlStateNormal];
    [_sortConcurrencyTestButton addTarget:self action:@selector(sortConcurrencyPerfTest:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sortConcurrencyTestButton];

    _initTestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_initTestButton setTitle:@"Initializer Test" forState:UIControlStateNormal];
    [_initTestButton addTarget:self action:@selector(initTest:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_initTestButton];

    _blockSelfRefButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_blockSelfRefButton setTitle:@"Block w/Self Ref Test" forState:UIControlStateNormal];
    [_blockSelfRefButton addTarget:self action:@selector(blockSelfRefTest:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_blockSelfRefButton];
}

- (void)testConspectus {
    NSArray* array = [self findSubviewsOfType:[UIButton class]];
    NSAssert([array count] == 5, @"Did you add a button?  Update this count.");

    UIView* view = [self findFirstSubviewOfType:[UIButton class]];
    NSAssert(view != nil, @"View was nil?");
    NSAssert([view isKindOfClass:[UIButton class]], @"View class was wrong?");

    [self applyBlockToSubviews:^(UIView *view, BOOL *stop) {
        UIButton* button = (id)view;
        button.alpha = 0;
        [UIView animateWithDuration:2.0 animations:^{
            button.alpha = 1;
        } completion:^(BOOL finished) {}];
    } ofClass:[UIButton class]];

    NSString* tree = [self dumpTree];
    NSAssert([tree length] > 0, @"Got nil from dumpTree?");
}

#pragma mark Callbacks

- (void)classObjectTest:(id)sender {
    NSLog(@" ");
    TXClassObjectTest* test = [[[TXClassObjectTest alloc] init] autorelease];
    [test doTest];
}

- (void)arrayPerfTest:(id)sender {
    NSLog(@" ");
    TXArrayPerfTest* test = [[[TXArrayPerfTest alloc] init] autorelease];
    [test doTest];
}

- (void)sortConcurrencyPerfTest:(id)sender {
    NSLog(@" ");
    TXStringSortTest* test = [[[TXStringSortTest alloc] init] autorelease];
    [test doTest];
}

- (void)initTest:(id)sender {
    NSLog(@" ");
    TXInitTest* test = [[[TXInitTest alloc] init] autorelease];
    [test doTest];
}

- (void)blockSelfRefTest:(id)sender {
    NSLog(@" ");
    TXBlockSelfRefTest* test = [[[TXBlockSelfRefTest alloc] init] autorelease];
    [test doTest];
}

@end
