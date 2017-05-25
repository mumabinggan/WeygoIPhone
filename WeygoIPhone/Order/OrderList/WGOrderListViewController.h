//
//  WGOrderListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGOrderListItem.h"
#import "WGOrderListRequest.h"

@interface WGOrderListViewController : WGViewController
{
    TWRefreshTableView *_tableView;
    NSMutableArray *_orderMArray;
}

@property (nonatomic, assign) WGOrderListType type;

- (void)refreshUI;

@end
