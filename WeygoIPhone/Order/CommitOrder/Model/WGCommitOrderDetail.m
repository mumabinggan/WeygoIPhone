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
        
        if (![NSString isNullOrEmpty:settlement.couponCode]) {
            WGCoupon *coupon = [[WGCoupon alloc] init];
            coupon.couponCode = settlement.couponCode;
            coupon.isSelected = YES;
            _coupon = coupon;
        }
        
        _integration = settlement.integral;
        
        _useIntegration = settlement.useIntegral;
    }
    return self;
}

- (NSString *)useIntegrationString {
    return (_useIntegration == YES) ? kStr(@"CommitOrder_Use_Score") : kStr(@"CommitOrder_No_Use_Score");
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

- (NSArray *)currentTimes {
    for (WGSettlementDate *date in _deliverTimes) {
        if (date.id == _currentDateId) {
            return date.times;
        }
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
    for (WGSettlementPayMethod *item in _payMethods) {
        if ([item.id isEqualToString:_currentPayId]) {
            return item.name;
        }
    }
    return nil;
}

@end
