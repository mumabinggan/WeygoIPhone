//
//  WGGoodDetailRecommendResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/7/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetailRecommendResponse.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGGoodDetailRecommendResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
