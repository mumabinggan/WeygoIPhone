//
//  WGOverHeightResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGOverHeightDetail.h"
#import "WGSettlementResultResponse.h"

@class WGAddressBussiness;

@interface WGOverHeightResponse : WGResponse

@property (nonatomic, strong) WGAddressBussiness *data;

@end

@interface WGAddressBussiness : WGObject

@property (nonatomic, strong) NSArray *overWeight;

@property (nonatomic, strong) NSArray *deliverTimes;

@property (nonatomic, strong) NSString *minPriceTips;

@property (nonatomic, strong) WGSettlementConsumePrice *price;

@end
