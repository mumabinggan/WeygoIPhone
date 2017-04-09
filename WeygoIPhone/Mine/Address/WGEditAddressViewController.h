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
}

@property (nonatomic, assign) long long addressId;

@property (nonatomic, strong) void (^onApply)();

- (void)refreshUI;

@end
