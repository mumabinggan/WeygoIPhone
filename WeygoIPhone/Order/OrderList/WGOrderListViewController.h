//
//  WGOrderListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGOrderListItem.h"

@interface WGOrderListViewController : WGViewController
{
    TWRefreshTableView *_tableView;
    NSMutableArray *_orderMArray;
}

- (void)refreshUI;

@end
