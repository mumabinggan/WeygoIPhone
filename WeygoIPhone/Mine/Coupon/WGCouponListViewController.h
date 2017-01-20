//
//  WGCouponListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@class WGCouponCode;
@class WGCoupon;

@interface WGCouponListViewController : WGViewController
{
    NSArray *_dataArray;
}

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) void (^onUse)(WGObject *object);

@end
