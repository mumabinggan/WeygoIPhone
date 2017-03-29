//
//  WGClassifyResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/27.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyResponse.h"
#import "WGClassifyItem.h"

@implementation WGClassifyResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    return [super classForArray:propertyName];
}

@end
