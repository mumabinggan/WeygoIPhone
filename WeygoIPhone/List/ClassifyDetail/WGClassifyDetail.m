//
//  WGClassifyDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetail.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGClassifyItem.h"

@implementation WGClassifyDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goodArray" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    if ([@"subClassifyArray" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    return nil;
}

@end
