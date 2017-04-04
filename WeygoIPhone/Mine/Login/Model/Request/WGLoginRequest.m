//
//  WGLoginRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginRequest.h"
#import "WGGoodInLocalCart.h"

@implementation WGLoginRequest

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"shopCarts" isEqualToString:propertyName]) {
        return [WGGoodInLocalCart class];
    }
    return [super classForArray:propertyName];
}

- (NSString *)api {
    return @"customer/login?";
}

@end
