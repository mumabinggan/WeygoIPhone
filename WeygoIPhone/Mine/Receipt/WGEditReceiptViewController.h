//
//  WGAddReceiptViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGReceipt.h"

@interface WGEditReceiptViewController : WGViewController
{
    JHTableView *_tableView;
    NSArray     *_placeholderArray;
    
    NSArray *_countryArray;
}

@property (nonatomic, copy) WGReceipt *receipt;

@property (nonatomic, strong) void (^onApply)(WGReceipt *receipt);

- (void)refreshUI;

@end
