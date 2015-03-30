//
//  DataSorter.m
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import "DataSorter.h"
#define M 100
#define tupleSize 8

@implementation DataSorter
+ (void)sortDataWithPath:(NSString *)filePath{
    NSData* reader = [NSData dataWithContentsOfFile:filePath];
    NSMutableData* writer = [[NSMutableData alloc] init];
    for (int i=0; i<M; i++) {
        NSMutableArray *tuples = [[NSMutableArray alloc] initWithCapacity:M];
        for (int j=0; j<M; j++) {
            int32_t a;
            int32_t b;
            [reader getBytes:&a range:NSMakeRange(i*M*tupleSize+2*j*sizeof(int32_t), sizeof(a))];
            [reader getBytes:&b range:NSMakeRange(i*M*tupleSize+2*j*sizeof(int32_t)+sizeof(a), sizeof(b))];
            [tuples addObject:@[@(a),@(b)]];
        }

        [tuples sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber *num1 = ((NSArray *)obj1)[0];
            NSNumber *num2 = ((NSArray *)obj2)[0];
            return [num1 compare:num2];
        }];
        
        for (int j=0; j<M; j++) {
            int32_t a = ((NSNumber *)(((NSArray *)tuples[j])[0])).intValue;
            int32_t b = ((NSNumber *)(((NSArray *)tuples[j])[1])).intValue;
            [writer appendBytes:&a length:sizeof(a)];
            [writer appendBytes:&b length:sizeof(b)];
        }
        
    }
    [writer writeToFile:filePath atomically:YES];
    writer = [[NSMutableData alloc] init];
    reader = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *allTuples = [[NSMutableArray alloc] initWithCapacity:M*M];
    for (int i=0; i<M*M; i++) {
        int32_t a;
        int32_t b;
        [reader getBytes:&a range:NSMakeRange(2*i*sizeof(int32_t), sizeof(a))];
        [reader getBytes:&b range:NSMakeRange(2*i*sizeof(int32_t)+sizeof(a), sizeof(b))];
        [allTuples addObject:@[@(a),@(b)]];
    }
    [allTuples sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *num1 = ((NSArray *)obj1)[0];
        NSNumber *num2 = ((NSArray *)obj2)[0];
        return [num1 compare:num2];
    }];
    [allTuples enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL *stop) {
        int32_t a = ((NSNumber *)(obj[0])).intValue;
        int32_t b = ((NSNumber *)(obj[1])).intValue;
        [writer appendBytes:&a length:sizeof(a)];
        [writer appendBytes:&b length:sizeof(b)];
    }];
    [writer writeToFile:filePath atomically:YES];
}



@end
