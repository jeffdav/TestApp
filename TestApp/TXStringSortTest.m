//
//  TXStringSortTest.m
//  TestApp
//
//  Created by Kevin Ferron on 3/15/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXStringSortTest.h"

@implementation TXStringSortTest

static NSString* const letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(void)doSortTests
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < 100000; ++i) {
        [array addObject:[self genRandStringLength:10]];
    }
    
    CFAbsoluteTime total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Array gen time: %f", total);
    
    start = CFAbsoluteTimeGetCurrent();
    
    NSArray* reverseSortConcurrent = [array sortedArrayWithOptions:(NSSortConcurrent | NSSortStable) usingComparator:^(id str1, id str2) { return [str2 compare:str1]; }];
    
    
    total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Concurrent Reverse Sort: %f", total);
    
    [reverseSortConcurrent count];
    
    start = CFAbsoluteTimeGetCurrent();
    
    NSArray* reverseSortNonConcurrent = [array sortedArrayWithOptions:NSSortStable usingComparator:^(id str1, id str2) { return [str2 compare:str1]; }];

    total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Nonconcurrent Reverse Sort: %f", total);
    
    [reverseSortNonConcurrent count];      
      
}

-(NSString *)genRandStringLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

-(void)doTest {
    [self doSortTests];
}


@end
