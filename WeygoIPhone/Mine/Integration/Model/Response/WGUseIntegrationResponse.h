//
//  WGUseIntegrationResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGIntegration.h"
#import "WGSettlementResult.h"

@class WGUseIntegrationData;

@interface WGUseIntegrationResponse : WGResponse

@property (nonatomic, strong) WGUseIntegrationData *data;

@end

@interface WGUseIntegrationData : WGObject

@property (nonatomic, strong) WGSettlementConsumePrice *price;

@end
