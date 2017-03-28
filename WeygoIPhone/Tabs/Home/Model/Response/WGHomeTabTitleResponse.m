//
//  WGHomeTabTitleResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabTitleResponse.h"
#import "WGTitleItem.h"

@implementation WGHomeTabTitleResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGTitleItem class];
    }
    return [super classForArray:propertyName];
}

@end
