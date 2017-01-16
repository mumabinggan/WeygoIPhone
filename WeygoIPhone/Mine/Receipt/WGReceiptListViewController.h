//
//  WGReceiptListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@class WGReceipt;

@interface WGReceiptListViewController : WGViewController
{
    NSArray *_dataArray;
}

@property (nonatomic, copy) void (^onUse)(WGReceipt *receipt);

@property (nonatomic, copy) void (^onClear)();

- (void)refreshTableView;

@end
