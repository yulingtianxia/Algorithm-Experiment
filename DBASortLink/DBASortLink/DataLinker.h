//
//  DataLinker.h
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLinker : NSObject
+ (NSArray *)linkTableR:(NSString *) pathR withTableS:(NSString *) pathS;
@end
