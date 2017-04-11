//
//  WGShopCartCountResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/11.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGShopCartCountData;

@interface WGShopCartCountResponse : WGResponse

@property (nonatomic, strong) WGShopCartCountData *data;

@end

@interface WGShopCartCountData : WGObject

@property (nonatomic, assign) long long goodCount;

@end
