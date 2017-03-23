//
//  WGUpdateOrderCouponRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGUpdateOrderCouponRequest : WGRequest

@property (nonatomic, assign) NSInteger settlementId;

@property (nonatomic, assign) NSInteger couponId;

@end
