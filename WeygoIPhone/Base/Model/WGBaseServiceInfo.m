//
//  WGBaseServiceInfo.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseServiceInfo.h"
#import "WGPostCodeItem.h"

@implementation WGBaseServiceInfo

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"postcodes" isEqualToString:propertyName]) {
        return [NSString class];
    }
    return [super classForArray:propertyName];
}

@end
