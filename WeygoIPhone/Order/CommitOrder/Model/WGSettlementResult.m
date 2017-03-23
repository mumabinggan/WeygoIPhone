//
//  WGSettlementResult.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSettlementResult.h"
#import "WGOrderGoodItem.h"

@implementation WGSettlementResult

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"deliverTimes" isEqualToString:propertyName]) {
        return [WGSettlementDate class];
    }
    else if ([@"payMethods" isEqualToString:propertyName]) {
        return [WGSettlementPayMethod class];
    }
    else if ([@"goods" isEqualToString:propertyName]) {
        return [WGOrderGoodItem class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGSettlementPayMethod

@end

@implementation WGSettlementDate

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"times" isEqualToString:propertyName]) {
        return [WGSettlementTime class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGSettlementTime

@end

@implementation WGSettlementConsumePrice

@end

@implementation WGSettlementTips

@end
