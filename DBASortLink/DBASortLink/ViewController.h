//
//  ViewController.h
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource,NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *dataTable;


@end

