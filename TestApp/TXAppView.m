//
//  TXAppView.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXAppView.h"

#include "TXInlineFun.h"

#import "TXClassObjectTest.h"

@interface TXAppView () {
  @private
    UIButton* _classObjectTestButton;
}
-(void)classObjectTest:(id)sender;
@end

@implementation TXAppView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor grayColor];
        
        _classObjectTestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_classObjectTestButton setTitle:@"Class Object Test" forState:UIControlStateNormal];
        [_classObjectTestButton addTarget:self action:@selector(classObjectTest:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_classObjectTestButton];
    }
    return self;
}

- (void)layoutSubviews {
    CGSize size = self.frame.size;

    [_classObjectTestButton sizeToFit];
    CGRect frame = _classObjectTestButton.frame;
    frame.origin.x = CenterDim(size.width, frame.size.width);
    frame.origin.y = CenterDim(size.height, frame.size.height);
    _classObjectTestButton.frame = frame;
}

#pragma mark Callbacks

- (void)classObjectTest:(id)sender {
    TXClassObjectTest* test = [[[TXClassObjectTest alloc] init] autorelease];
    [test doTest];
}

@end
