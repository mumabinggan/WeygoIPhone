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
        //地址
        _address = settlement.address;
        
        //时间
        _deliverTime = [[WGCommitOrderDeliverTime alloc] init];
        _deliverTime.deliverTimes = settlement.deliverTimes;
        
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
        
        _coupon = settlement.coupon;
        
        _integration = settlement.integral;
        
        _useIntegration = settlement.useIntegral;
        
        _minPriceTips = settlement.minPriceTips;
    }
    return self;
}

- (NSString *)useIntegrationString {
    return (_useIntegration == 1) ? kStr(@"CommitOrder_Use_Score") : kStr(@"CommitOrder_No_Use_Score");
}

@end

@implementation WGCommitOrderDeliverTime

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"deliverTimes" isEqualToString:propertyName]) {
        return [WGSettlementDate class];
    }
    return [super classForArray:propertyName];
}

- (void)resetWithTimes:(NSArray *)deliverTimes {
    _deliverTimes = deliverTimes;
    _currentTimeId = nil;
    _currentDateId = nil;
}

- (NSString *)currentDate {
    if ([NSString isNullOrEmpty:_currentDateId]) {
        if (_deliverTimes && _deliverTimes.count > 0) {
            WGSettlementDate *item = _deliverTimes[0];
            _currentDateId = item.id;
        }
    }
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
            if ([NSString isNullOrEmpty:_currentTimeId]) {
                if (date.times && date.times.count > 0) {
                    WGSettlementTime *time = date.times[0];
                    _currentTimeId = time.id;
                }
            }
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

- (NSArray *)currentTimes {
    for (WGSettlementDate *date in _deliverTimes) {
        if (date.id == _currentDateId) {
            return date.times;
        }
    }
    return nil;
}

- (NSString *)defaultTimeId {
    NSArray *times = [self currentTimes];
    if (times.count > 0) {
        WGSettlementTime *time = times[0];
        return time.id;
    }
    return nil;
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
    if ([NSString isNullOrEmpty:_currentPayId]) {
        if (_payMethods.count > 0) {
            WGSettlementPayMethod *method = _payMethods[0];
            _currentPayId = method.id;
        }
    }
    for (WGSettlementPayMethod *item in _payMethods) {
        if ([item.id isEqualToString:_currentPayId]) {
            return item.name;
        }
    }
    return nil;
}

@end
