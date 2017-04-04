//
//  WGShopCartViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@class WGShopCart;

@interface WGShopCartViewController : WGViewController
{
    WGShopCart *_data;
    TWRefreshTableView *_tableView;
}

- (void)refreshUI;

- (void)refreshTableView;

- (void)intoCommitOrderViewController;

@end
