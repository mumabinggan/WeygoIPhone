//
//  WGHotSearchResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHotSearchResponse.h"
#import "WGSearchKeywordItem.h"

@implementation WGHotSearchResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGSearchKeywordItem class];
    }
    return [super classForArray:propertyName];
}

@end
