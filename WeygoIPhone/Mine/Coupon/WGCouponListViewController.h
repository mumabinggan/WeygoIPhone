//
//  WGCouponListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGSettlementResult.h"

@class WGCouponCode;
@class WGCoupon;

@interface WGCouponListViewController : WGViewController
{
    NSMutableArray *_dataMArray;
    TWRefreshTableView *_tableView;
    JHButton *_activateBtn;
}

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) WGCoupon *coupon;

@property (nonatomic, copy) void (^onUse)(WGObject *object, WGSettlementConsumePrice *price);

- (void)refreshUI;

@end
