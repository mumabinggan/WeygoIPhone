//
//  WGEditAddressViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGAddress.h"

@interface WGEditAddressViewController : WGViewController
{
    JHTableView *_tableView;
    NSArray     *_placeholderArray;
    WGAddress *_address;
    
    NSArray *_cityArray;
    JHView *_sortPickerBgView;
    JHButton *_closeBtn;
}

@property (nonatomic, assign) long long addressId;

@property (nonatomic, assign) BOOL needRefresh;

@property (nonatomic, strong) void (^onApply)(WGAddress *address);

- (void)refreshUI;

@end
