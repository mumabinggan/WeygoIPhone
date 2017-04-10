//
//  WGCouponListViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCouponListViewController.h"

@interface WGCouponListViewController (Request)

- (void)loadListResponse:(BOOL)refresh pulling:(BOOL)pulling;

- (void)loadUseCoupon:(WGCoupon *)coupon remove:(BOOL)remove;

@end
