//
//  DataFactory.m
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import "DataFactory.h"
#define lengthOfTable 10000
@implementation DataFactory
//R(ID,phone) S(ID,age)

+ (NSArray *)generateDataFiles {
    NSString *pathOfR = @"/Users/yangxiaoyu/Desktop/R.dat";
    NSString *pathOfS = @"/Users/yangxiaoyu/Desktop/S.dat";
    NSMutableData* writerR = [[NSMutableData alloc] init];
    NSMutableData* writerS = [[NSMutableData alloc] init];
    for(int i=0;i<lengthOfTable;i++){
        int32_t id1 = arc4random_uniform(1000);
        int32_t phone = arc4random_uniform(9999);
        int32_t id2 = arc4random_uniform(1000);
        int32_t age = arc4random_uniform(100);
        [writerR appendBytes:&id1 length:sizeof(id1)];
        [writerR appendBytes:&phone length:sizeof(phone)];
        [writerS appendBytes:&id2 length:sizeof(id2)];
        [writerS appendBytes:&age length:sizeof(age)];
    }
    [writerR writeToFile:pathOfR atomically:YES];
    [writerS writeToFile:pathOfS atomically:YES];
    return @[pathOfR,pathOfS];
}
@end
