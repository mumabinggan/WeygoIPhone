//
//  WGBenefitTabResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBenefitTabResponse.h"
#import "WGTitleItem.h"

@implementation WGBenefitTabResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGTitleItem class];
    }
    return [super classForArray:propertyName];
}

@end
