//
//  TXClassObjectTest.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXClassObjectTest.h"

@interface TXClassA : NSObject

@property(nonatomic, assign) int foo;

@end

@implementation TXClassA

@synthesize foo = _foo;

+ (void)initialize {
    NSLog(@"[TXClassA initialize]");
    NSLog(@"  self = %@", self);
    NSLog(@"  [self class] = %@", [self class]);
    NSLog(@" ");
}

- (id)init {
    if ((self = [super init])) {
        NSLog(@"[TXClassA init]");
        NSLog(@"  self = %@", self);
        NSLog(@"  [self class] = %@", [self class]);
        NSLog(@" ");
    }
    return self;
}

+ (void)classMethod {
    NSLog(@"[TXClassA classMethod]");
    NSLog(@"  self = %@", self);
    NSLog(@"  [self class] = %@", [self class]);
    NSLog(@" ");
}

@end

@interface TXClassB : TXClassA

@property(nonatomic, assign) int bar;

@end

@implementation TXClassB

@synthesize bar = _bar;

+ (void)initialize {
    NSLog(@"[TXClassB initialize]");
    NSLog(@"  self = %@", self);
    NSLog(@"  [self class] = %@", [self class]);
    NSLog(@" ");
}

- (id)init {
    if ((self = [super init])) {
        NSLog(@"[TXClassB init]");
        NSLog(@"  self = %@", self);
        NSLog(@"  [self class] = %@", [self class]);
        NSLog(@" ");
    }
    return self;
}

+ (void)classMethod {
    [super classMethod];
    NSLog(@"[TXClassB classMethod]");
    NSLog(@"  self = %@", self);
    NSLog(@"  [self class] = %@", [self class]);
    NSLog(@" ");
}

@end

@implementation TXClassObjectTest

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"[TXClassObjectTest observeValueForKeyPath:object:change:context]");
    NSLog(@"  change = %@", change);
    NSLog(@" ");
}

- (void)doTest {
    TXClassB* b = [[TXClassB alloc] init];
    [b release];
    b = nil;
    
    [TXClassB classMethod];

    TXClassA* a = [[TXClassA alloc] init];
    a.foo = 1;
    [a addObserver:self forKeyPath:@"foo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    a.foo++;
    [a removeObserver:self forKeyPath:@"foo"];
    [a release];
    a = nil;
}

@end
