//
//  WGMessageResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageResponse.h"
#import "WGMessageItem.h"

@implementation WGMessageResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGMessageItem class];
    }
    return [super classForArray:propertyName];
}

@end
