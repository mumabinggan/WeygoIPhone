//
//  WGIntegrationDetailRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGIntegrationDetailRequest.h"

@implementation WGIntegrationDetailRequest

- (id)init {
    self = [super init];
    if (self) {
        //_pageSize = 15;
    }
    return self;
}

- (NSString *)api {
    return @"customer/points?";
}

@end
