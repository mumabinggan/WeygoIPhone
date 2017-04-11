//
//  WGCommitOrderResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGCommitOrderData;

@interface WGCommitOrderResponse : WGResponse

@property (nonatomic, strong) WGCommitOrderData *data;

@end

@interface WGCommitOrderData : JHObject

@property (nonatomic, assign) long long orderId;

@end
