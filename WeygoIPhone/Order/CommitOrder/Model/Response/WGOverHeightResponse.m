//
//  WGOverHeightResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOverHeightResponse.h"
#import "WGSettlementResult.h"

@implementation WGOverHeightResponse

@end

@implementation WGAddressBussiness

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"overWeight" isEqualToString:propertyName]) {
        return [WGOverHeightDetail class];
    }
    else if ([@"deliverTimes" isEqualToString:propertyName]) {
        return [WGSettlementDate class];
    }
    return [super classForArray:propertyName];
}

@end
