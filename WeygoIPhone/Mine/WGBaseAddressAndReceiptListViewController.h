//
//  WGBaseAddressAndReceiptListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

typedef NS_ENUM(NSInteger, WGAddressListType) {
    WGAddressListTypeNormal,
    WGAddressListTypeCanUse,
};

@interface WGBaseAddressAndReceiptListViewController : WGViewController
{
    NSMutableArray *_dataMArray;
}

@property (nonatomic, assign) WGAddressListType type;

@property (nonatomic, copy) void (^onUse)(WGObject *object);

@property (nonatomic, copy) void (^onClear)();

- (void)refreshTableView;

@end
