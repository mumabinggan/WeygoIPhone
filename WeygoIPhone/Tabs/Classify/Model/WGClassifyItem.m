//
//  WGClassifyItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyItem.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGClassifyItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"subArray" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    if ([@"goodArray" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
