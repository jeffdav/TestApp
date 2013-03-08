//
//  TXArrayPerfTest.m
//  TestApp
//
//  Created by Jeff Davis on 3/7/13.
//  Copyright (c) 2013 Jeff Davis. All rights reserved.
//

#import "TXArrayPerfTest.h"

@implementation TXArrayPerfTest

- (CFAbsoluteTime)doNaiveTest {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();

    NSMutableArray* array = [NSMutableArray array];

    for (int i = 0; i < 10000; ++i) {
        [array addObject:[NSNumber numberWithInt:i]];
    }

    NSMutableArray* toRemove = [NSMutableArray array];
    for (NSNumber* num in array) {
        if ([num intValue] % 4 == 0) {
            [toRemove addObject:num];
        }
    }

    for (NSNumber* num in toRemove) {
        [array removeObject:num];
    }
    
    CFAbsoluteTime total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Naive removal total time: %f", total);
    return total;
}

- (CFAbsoluteTime)doBetterTest {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < 10000; ++i) {
        [array addObject:[NSNumber numberWithInt:i]];
    }
    
    NSMutableArray* toRemove = [NSMutableArray array];
    for (NSNumber* num in array) {
        if ([num intValue] % 4 == 0) {
            [toRemove addObject:num];
        }
    }

    [array removeObjectsInArray:toRemove];
    
    CFAbsoluteTime total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Better removal total time: %f", total);
    return total;
}

- (CFAbsoluteTime)doBestTest {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < 10000; ++i) {
        [array addObject:[NSNumber numberWithInt:i]];
    }
    
    NSIndexSet* indexes = [array indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return idx % 4 == 0;
    }];

    [array removeObjectsAtIndexes:indexes];
    
    CFAbsoluteTime total = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"Best removal total time: %f", total);
    return total;
}

- (void)doTest {
    static const int kRuns = 4;

    CFAbsoluteTime total = 0;
    for (int i = 0; i < kRuns; ++i) {
        total += [self doNaiveTest];
    }
    NSLog(@"Naive average: %f", total / kRuns);
    NSLog(@" ");
    
    total = 0;
    for (int i = 0; i < kRuns; ++i) {
        total += [self doBetterTest];
    }
    NSLog(@"Better average: %f", total / kRuns);
    NSLog(@" ");
    
    total = 0;
    for (int i = 0; i < kRuns; ++i) {
        total += [self doBestTest];
    }
    NSLog(@"Best average: %f", total / kRuns);
    NSLog(@" ");
}

@end
