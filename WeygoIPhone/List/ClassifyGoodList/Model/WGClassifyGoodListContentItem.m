//
//  WGClassifyGoodListContentsItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyGoodListContentItem.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGClassifyGoodListContentItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"contents" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return nil;
}

@end
