//
//  WGPaySuccessResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/12.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGPaySuccessData;

@interface WGPaySuccessResponse : WGResponse

@property (nonatomic, strong) WGPaySuccessData *data;

@end

@interface WGPaySuccessData : JHObject

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *currentTotalPriceUnUnit;

@end
