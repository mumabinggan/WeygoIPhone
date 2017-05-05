//
//  WGSearchResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSearchResponse.h"
#import "WGSearchKeywordItem.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGSearchResponse

@end

@implementation WGSearchData

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"classifys" isEqualToString:propertyName]) {
        return [WGSearchClassifyItem class];
    }
    if ([@"keywords" isEqualToString:propertyName]) {
        return [WGSearchKeywordItem class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGSearchClassifyItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end
