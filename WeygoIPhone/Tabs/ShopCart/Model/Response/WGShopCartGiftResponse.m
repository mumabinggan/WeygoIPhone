//
//  WGShopCartGiftResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartGiftResponse.h"
#import "WGShopCartGoodItem.h"

@implementation WGShopCartGiftResponse

@end

@implementation WGShopCartGiftData

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGShopCartGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
