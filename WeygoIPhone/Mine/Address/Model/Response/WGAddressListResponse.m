//
//  WGAddressListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListResponse.h"
#import "WGAddress.h"

@implementation WGAddressListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGAddress class];
    }
    return [super classForArray:propertyName];
}

@end
