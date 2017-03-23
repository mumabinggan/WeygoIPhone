//
//  WGSettlementResult.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@class WGSettlementTips;
@class WGSettlementConsumePrice;

@interface WGSettlementResult : WGObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSArray *deliverTimes;

@property (nonatomic, strong) NSArray *payMethods;

@property (nonatomic, strong) WGSettlementConsumePrice *price;

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) WGSettlementTips *tip;

@end

@interface WGSettlementPayMethod : WGObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *name;

@end

@interface WGSettlementDate : WGObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSArray *times;

@end


@interface WGSettlementTime : WGObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *time;

@end

@interface WGSettlementConsumePrice : WGObject

@property (nonatomic, assign) float totalPrice;

@property (nonatomic, assign) float deliverPrice;

@property (nonatomic, assign) float couponPrice;

@property (nonatomic, assign) float currentTotalPrice;

@property (nonatomic, assign) float reducePrice;

@end

@interface WGSettlementTips : WGObject

@property (nonatomic, strong) NSString *orderChangeTip;

@property (nonatomic, strong) NSString *orderPriceTip;

@property (nonatomic, strong) NSString *orderPriceDetailTip;

@end
