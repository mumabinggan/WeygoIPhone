//
//  WGDeleteGoodFromShopCartRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDeleteGoodFromShopCartRequest.h"

@implementation WGDeleteGoodFromShopCartRequest

- (id)init {
    self = [super init];
    if (self) {
        _cap = [WGApplication sharedApplication].currentPostCode;
    }
    return self;
}

- (NSString *)api {
    return @"cart/delete?";
}

@end
