//
//  WGKeywordSearchGoodListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGKeywordSearchGoodListResponse.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGKeywordSearchGoodListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
