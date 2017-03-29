//
//  WGCollectionListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCollectionListResponse.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGCollectionListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
