//
//  WGAddAddressRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddAddressRequest.h"

@implementation WGAddAddressRequest

- (NSString *)api {
    return @"customer/postAddress?";
}

- (NSString *)countryId {
    return @"IT";       //默认意大利
}

- (NSString *)city {
    if ([NSString isNullOrEmpty:_city]) {
        return @"MILANO";
    }
    return _city;
}

@end
