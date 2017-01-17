//
//  WGShopCart.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCart.h"
#import "WGShopCartGoodItem.h"

@implementation WGShopCart

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGShopCartGoodItem class];
    }
    return nil;
}

@end
