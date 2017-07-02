//
//  WGSettlementResult.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGAddress.h"
#import "WGCoupon.h"
#import "WGOverHeightDetail.h"

@class WGSettlementTips;
@class WGSettlementConsumePrice;

@interface WGSettlementResult : WGObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) WGAddress *address;

//@property (nonatomic, strong) NSString *couponCode;
@property (nonatomic, strong) WGCoupon *coupon;

@property (nonatomic, strong) NSArray *deliverTimes;

@property (nonatomic, strong) NSArray *payMethods;

@property (nonatomic, strong) WGSettlementConsumePrice *price;

@property (nonatomic, assign) WGIntegrationState useIntegral;  //1使用：0不使用
@property (nonatomic, assign) long long integral;
@property (nonatomic, strong) NSString *integralDescription;

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) WGSettlementTips *tip;

@property (nonatomic, assign) NSInteger goodsCount;

@property (nonatomic, strong) NSArray *overHeightDetail;

@end

@interface WGSettlementPayMethod : WGObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@end

@interface WGSettlementDate : WGObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *week;

@property (nonatomic, strong) NSArray *times;

@end


@interface WGSettlementTime : WGObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *time;

@end

@interface WGSettlementConsumePrice : WGObject

@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) NSString *deliverPrice;

@property (nonatomic, strong) NSString *couponPrice;

@property (nonatomic, strong) NSString *integralPrice;

@property (nonatomic, strong) NSString *currentTotalPrice;

@property (nonatomic, strong) NSString *currentTotalPriceUnUnit;

@property (nonatomic, strong) NSString *reducePrice;

@end

@interface WGSettlementTips : WGObject

@property (nonatomic, strong) NSString *orderChangeTip;

@property (nonatomic, strong) NSString *orderPriceTip;

@property (nonatomic, strong) NSString *orderPriceDetailTip;

@end
