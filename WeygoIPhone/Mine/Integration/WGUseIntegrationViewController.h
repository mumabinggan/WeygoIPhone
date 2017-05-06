//
//  WGUseIntegrationViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGSettlementResult.h"

@interface WGUseIntegrationViewController : WGViewController

@property (nonatomic, strong) void (^onApply)(WGSettlementConsumePrice *price, WGIntegrationState use);

@end
