//
//  WGGetVerifyCodeRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGetVerifyCodeRequest.h"

@implementation WGGetVerifyCodeRequest

- (NSString *)countryCode {
    if ([NSString isNullOrEmpty:_countryCode]) {
        _countryCode = @"+39";
    }
    return _countryCode;
}

- (NSString *)api {
    return @"customer/sendVerify?";
}

@end
