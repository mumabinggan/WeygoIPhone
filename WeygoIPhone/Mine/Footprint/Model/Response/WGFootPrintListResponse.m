//
//  WGFootPrintListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGFootPrintListResponse.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGFootPrintListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
