//
//  WGOrderListRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListRequest.h"

@implementation WGOrderListRequest

- (id)init {
    self = [super init];
    if (self) {
        _pageSize = 4;
    }
    return self;
}

- (NSString *)api {
    return @"orders/index?";
}

@end
