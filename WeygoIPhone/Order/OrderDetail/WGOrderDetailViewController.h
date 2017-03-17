//
//  WGOrderDetailViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGOrderDetail.h"

@interface WGOrderDetailViewController : WGViewController
{
    JHTableView *_tableView;
    WGOrderDetail *_orderDetail;
}

@property (nonatomic, assign) long long orderId;

- (void)refreshUI;

@end
