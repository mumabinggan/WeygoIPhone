//
//  WGDealFailureProductsRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDealFailureProductsRequest.h"

@implementation WGDealFailureProductsRequest

- (id)init {
    self = [super init];
    if (self) {
        _cap = [WGApplication sharedApplication].currentPostCode;
    }
    return self;
}

- (NSString *)api {
    return @"cart/updateProducts?";
}

@end
