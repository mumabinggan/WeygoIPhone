//
//  WGCouponListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCouponListResponse.h"
#import "WGCoupon.h"

@implementation WGCouponListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGCoupon class];
    }
    return [super classForArray:propertyName];
}

@end
