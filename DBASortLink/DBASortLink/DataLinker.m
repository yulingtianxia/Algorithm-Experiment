//
//  DataLinker.m
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import "DataLinker.h"
#define M 100
@implementation DataLinker
+ (NSArray *)linkTableR:(NSString *) pathR withTableS:(NSString *) pathS {
    NSData* readerR = [NSData dataWithContentsOfFile:pathR];
    NSData* readerS = [NSData dataWithContentsOfFile:pathS];
//    NSMutableData* writer = [[NSMutableData alloc] init];
    NSMutableArray *result = [NSMutableArray array];
    int needleR=0;
    int needleS=0;
    NSMutableSet *arrayR = [NSMutableSet set];
    NSMutableSet *arrayS = [NSMutableSet set];
//    NSMutableArray *arrayR = [NSMutableArray array];
//    NSMutableArray *arrayS = [NSMutableArray array];
    int lastRa = 0;
    int lastSa = 0;
    while (needleR<M*M&&needleS<M*M) {
        int32_t Ra;
        int32_t Rb;
        [readerR getBytes:&Ra range:NSMakeRange(2*needleR*sizeof(int32_t), sizeof(int32_t))];
        [readerR getBytes:&Rb range:NSMakeRange(2*needleR*sizeof(int32_t)+sizeof(int32_t), sizeof(int32_t))];
        if (lastRa==Ra) {
            [arrayR addObject:@(Rb)];
            needleR++;
        }
        int32_t Sa;
        int32_t Sb;
        [readerS getBytes:&Sa range:NSMakeRange(2*needleS*sizeof(int32_t), sizeof(int32_t))];
        [readerS getBytes:&Sb range:NSMakeRange(2*needleS*sizeof(int32_t)+sizeof(int32_t), sizeof(int32_t))];
        if (lastSa==Sa) {
            [arrayS addObject:@(Sb)];
            needleS++;
        }
        //数组充满
        if (lastRa!=Ra&&lastSa!=Sa) {
            if (lastRa==lastSa) {//准备连接
                for (int i=0; i<arrayR.count; i++) {
                    for (int j=0; j<arrayS.count; j++) {
                        NSArray *tuple = @[@(lastRa),arrayR.allObjects[i],arrayS.allObjects[j]];
//                        NSArray *tuple = @[@(lastRa),arrayR[i],arrayS[j]];
                        [result addObject:tuple];
                    }
                }
                [arrayR removeAllObjects];
                [arrayR addObject:@(Ra)];
                lastRa = Ra;
                needleR++;
                [arrayS removeAllObjects];
                [arrayS addObject:@(Sa)];
                lastSa = Sa;
                needleS++;
            }
            else if (lastRa<lastSa) {//S等待R
                [arrayR removeAllObjects];
                [arrayR addObject:@(Ra)];
                lastRa = Ra;
                needleR++;
            }
            else{//R等待S
                [arrayS removeAllObjects];
                [arrayS addObject:@(Sa)];
                lastSa = Sa;
                needleS++;
            }
        }
    }
    return result;
}
@end
