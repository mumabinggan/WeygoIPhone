//
//  WGClientServiceCenterResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClientServiceCenterResponse.h"

@implementation WGClientServiceCenterResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGClientServiceCenterItem class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGClientServiceCenterItem

@end
