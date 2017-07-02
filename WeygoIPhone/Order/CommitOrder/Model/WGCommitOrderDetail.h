//
//  WGOrderDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGAddress.h"
#import "WGReceipt.h"
#import "WGSettlementResult.h"
#import "WGCoupon.h"

@class WGCommitOrderPay;
@class WGCommitOrderDeliverTime;

@interface WGCommitOrderDetail : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) WGAddress *address;

@property (nonatomic, strong) WGReceipt *receipt;

@property (nonatomic, strong) WGCoupon *coupon;

@property (nonatomic, strong) NSString *remark;     //备注

@property (nonatomic, assign) WGIntegrationState useIntegration;

@property (nonatomic, assign) long long integration;

// some from settlement
@property (nonatomic, strong) WGCommitOrderDeliverTime *deliverTime;

// some from settlement
@property (nonatomic, strong) WGCommitOrderPay *payMothod;

//from settlement
@property (nonatomic, strong) WGSettlementConsumePrice *consumePrice;

//from settlement
@property (nonatomic, strong) WGSettlementTips *tip;

//from settlement
@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) NSString *minPriceTips;

//for self use
@property (nonatomic, strong) NSString *useIntegrationString;

- (id)initWithSettlementResult:(WGSettlementResult *)settlement;

@end

@interface WGCommitOrderDeliverTime : WGObject

@property (nonatomic, strong) NSString *currentDateId;

@property (nonatomic, strong) NSString *currentTimeId;

//from settlement
@property (nonatomic, strong) NSArray *deliverTimes;

//for self use
@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, strong) NSString *currentTime;

@property (nonatomic, strong) NSArray *currentTimes;

- (void)resetWithTimes:(NSArray *)deliverTimes;

@end

@interface WGCommitOrderPay : WGObject

@property (nonatomic, strong) NSString *currentPayId;

//from settlement
@property (nonatomic, strong) NSArray *payMethods;

//for self use
@property (nonatomic, strong) NSString *payName;

@end
