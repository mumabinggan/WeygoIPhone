//
//  WGActiveCouponResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGSettlementResult.h"

@class WGActiveCouponData;

@interface WGActiveCouponResponse : WGResponse

@property (nonatomic, strong) WGActiveCouponData *data;

@end

@interface WGActiveCouponData : WGObject

@property (nonatomic, strong) WGSettlementConsumePrice *price;

@end
