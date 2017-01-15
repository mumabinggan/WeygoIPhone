//
//  WGClassifyGoodList.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyGoodList.h"
#import "WGClassifyGoodListContentItem.h"

@implementation WGClassifyGoodList

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"contents" isEqualToString:propertyName]) {
        return [WGClassifyGoodListContentItem class];
    }
    return nil;
}

@end
