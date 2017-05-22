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
    JHView *_sortPickerBgView;
    JHButton *_closeBtn;
}

@property (nonatomic, copy) WGReceipt *receipt;

@property (nonatomic, strong) void (^onApply)(WGReceipt *receipt);

@property (nonatomic, strong) void (^onCancel)();

- (void)refreshUI;

@end
