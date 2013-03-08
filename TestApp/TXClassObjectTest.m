//
//  TXClassObjectTest.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXClassObjectTest.h"

@interface TXClassA : NSObject
@end

@implementation TXClassA

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
@end

@implementation TXClassB

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

- (void)doTest {
    TXClassB* b = [[TXClassB alloc] init];
    [b release];
    b = nil;
    
    [TXClassB classMethod];
}

@end
