//
//  WGShopCartResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartResponse.h"
#import "WGShopCartGoodItem.h"

@implementation WGShopCartResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGShopCartGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
