//
//  ViewController.m
//  DBASortLink
//
//  Created by 杨萧玉 on 15/3/29.
//  Copyright (c) 2015年 杨萧玉. All rights reserved.
//

#import "ViewController.h"
#import "DataFactory.h"
#import "DataSorter.h"
#import "DataLinker.h"

@implementation ViewController
NSArray *dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSArray *paths = [DataFactory generateDataFiles];
    [DataSorter sortDataWithPath:paths[0]];
    [DataSorter sortDataWithPath:paths[1]];
    dataArray = [DataLinker linkTableR:paths[0] withTableS:paths[1]];
}

- (void)setRepresentedObject:(id)representedObject {
    super.representedObject = representedObject;

    // Update the view, if already loaded.
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return dataArray.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    int column=0;
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        column=0;
    }
    else if ([tableColumn.identifier isEqualToString:@"phone"]) {
        column=1;
    }
    else if ([tableColumn.identifier isEqualToString:@"age"]) {
        column=2;
    }
    NSArray *tuple = dataArray[row];
    return tuple[column];
}
@end
