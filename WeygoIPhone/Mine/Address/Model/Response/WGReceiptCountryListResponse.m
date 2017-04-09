//
//  WGReceiptCountryListResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGReceiptCountryListResponse.h"

@implementation WGReceiptCountryListResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGReceiptCountryListItem class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGReceiptCountryListItem

@end
