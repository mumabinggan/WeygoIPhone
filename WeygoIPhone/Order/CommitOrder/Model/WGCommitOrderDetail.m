//
//  WGOrderDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderDetail.h"
#import "WGOrderGoodItem.h"

@implementation WGCommitOrderDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGOrderGoodItem class];
    }
    return [super classForArray:propertyName];
}

- (id)initWithSettlementResult:(WGSettlementResult *)settlement {
    self = [super init];
    if (self) {
        //goods
        _goods = settlement.goods;
        
        //payMethods
        WGCommitOrderPay *pay = [[WGCommitOrderPay alloc] init];
        pay.payMethods = settlement.payMethods;
        _payMothod = pay;
        
        //consumePrice
        _consumePrice = settlement.price;
        
        //tips
        _tip = settlement.tip;
    }
    return self;
}

@end

@implementation WGCommitOrderDeliverTime

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"deliverTimes" isEqualToString:propertyName]) {
        return [WGSettlementDate class];
    }
    return [super classForArray:propertyName];
}

- (NSString *)currentDate {
    for (WGSettlementDate *item in _deliverTimes) {
        if ([item.id isEqualToString:_currentDateId]) {
            _currentDate = item.date;
            break;
        }
    }
    return _currentDate;
}

- (NSString *)currentTime {
    for (WGSettlementDate *date in _deliverTimes) {
        if (date.id == _currentDateId) {
            for (WGSettlementTime *time in date.times) {
                if ([time.id isEqualToString:_currentTimeId]) {
                    _currentTime = time.time;
                    break;
                }
            }
            break;
        }
    }
    return _currentTime;
}

@end

@implementation WGCommitOrderPay

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"payMethods" isEqualToString:propertyName]) {
        return [WGSettlementPayMethod class];
    }
    return [super classForArray:propertyName];
}

- (NSString *)payName {
    for (WGSettlementPayMethod *item in _payMethods) {
        if ([item.id isEqualToString:_currentPayId]) {
            return item.name;
        }
    }
    return nil;
}

@end
