//
//  WGAddressCityListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressCityListResponse.h"

@implementation WGAddressCityListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGAddressCityListItem class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGAddressCityListItem

@end
