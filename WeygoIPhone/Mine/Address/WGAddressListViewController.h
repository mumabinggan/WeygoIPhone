//
//  WGAddressListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseAddressAndReceiptListViewController.h"

@interface WGAddressListViewController : WGBaseAddressAndReceiptListViewController

@property (nonatomic, assign) long long addressId;

- (void)handleUse:(WGObject *)object;

@end
