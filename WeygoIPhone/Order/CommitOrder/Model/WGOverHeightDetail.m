//
//  WGOverHeightDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOverHeightDetail.h"
#import "WGOverHeightGoodItem.h"

@implementation WGOverHeightDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGOverHeightGoodItem class];
    }
    return [super classForArray:propertyName];
}

- (float)currentRise {
    float totalRise = 0.0f;
    for (WGOverHeightGoodItem *item in _goods) {
        totalRise += item.rise*item.goodCount;
    }
    return totalRise;
}

@end
