//
//  WGBaseEditAddressAndReceiptViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGBaseEditAddressAndReceiptViewController : WGViewController
{
    JHTableView *_tableView;
    NSArray     *_placeholderArray;
    NSMutableArray  *_contentMArray;
}

@property (nonatomic, copy) void (^onApply)();

@end
