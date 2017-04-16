//
//  WGAddGoodToCartResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGAddGoodToCartData;

@interface WGAddGoodToCartResponse : WGResponse

@property (nonatomic, strong) WGAddGoodToCartData *data;

@end

@interface WGAddGoodToCartData : WGObject

@property (nonatomic, assign) long long goodCount;

@end
