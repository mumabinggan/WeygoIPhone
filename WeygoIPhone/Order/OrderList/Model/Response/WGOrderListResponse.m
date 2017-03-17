//
//  WGOrderListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListResponse.h"
#import "WGOrderListItem.h"

@implementation WGOrderListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGOrderListItem class];
    }
    return [super classForArray:propertyName];
}

@end
