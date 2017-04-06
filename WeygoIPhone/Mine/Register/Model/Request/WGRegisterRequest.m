//
//  WGRegisterRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRegisterRequest.h"

@implementation WGRegisterRequest

- (id)init {
    self = [super init];
    if (self) {
        if (![WGApplication sharedApplication].isLogined) {
            _cap = [WGApplication sharedApplication].currentPostCode;
        }
    }
    return self;
}

- (NSString *)countryCode {
    if ([NSString isNullOrEmpty:_countryCode]) {
        _countryCode = @"+39";
    }
    return _countryCode;
}

- (NSString *)api {
    return @"customer/register?";
}

@end
