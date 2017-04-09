//
//  WGActiveCouponRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGActiveCouponRequest : WGGuestRequest

@property (nonatomic, strong) NSString *couponCode;

@property (nonatomic, assign) int remove;   ////0：添加优惠券; 1: 取消优惠券

@property (nonatomic, assign) long long couponId;

@end
