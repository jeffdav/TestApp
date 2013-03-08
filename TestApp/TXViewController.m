//
//  TXViewController.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXViewController.h"

#import "TXAppView.h"

@interface TXViewController ()

@end

@implementation TXViewController

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)loadView {
    self.view = [[[TXAppView alloc] initWithFrame:CGRectZero] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
