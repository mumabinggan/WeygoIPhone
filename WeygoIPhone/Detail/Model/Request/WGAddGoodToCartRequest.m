//
//  WGAddGoodToCartRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddGoodToCartRequest.h"

@implementation WGAddGoodToCartRequest

- (id)init {
    self = [super init];
    if (self) {
        if (([WGApplication sharedApplication].isLogined && [NSString isNullOrEmpty:[WGApplication sharedApplication].currentPostCode])) {
            _cap = [WGApplication sharedApplication].currentPostCode;
        }
    }
    return self;
}

- (NSString *)api {
    return @"cart/add?";
}

@end
