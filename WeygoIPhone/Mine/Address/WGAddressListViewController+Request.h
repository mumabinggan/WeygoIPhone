//
//  WGAddressListViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListViewController.h"
#import "WGAddress.h"

@interface WGAddressListViewController (Request)

- (void)loadAddressList;

- (void)loadDeleteAddress:(WGAddress *)address;

- (void)loadSetDefaultAddress:(WGAddress *)address;

@end
