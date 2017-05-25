//
//  WGRebuyOrderResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGAddGoodToCartData.h"

@interface WGRebuyOrderResponse : WGResponse

@property (nonatomic, strong) WGAddGoodToCartData *data;

@end
