//
//  WGOrderExpireGood.m
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderExpireGood.h"
#import "WGHomeFloorContentItem.h"

@implementation WGOrderExpireGood

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGHomeFloorContentItem class];
    }
    return [super classForArray:propertyName];
}

@end
