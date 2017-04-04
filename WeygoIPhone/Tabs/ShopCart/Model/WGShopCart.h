//
//  WGShopCart.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@class WGShopCartPrice;

@interface WGShopCart : WGObject

@property (nonatomic, strong) WGShopCartPrice *shopCartPrice;

@property (nonatomic, strong) NSArray *goods;

//for self use
@property (nonatomic, assign, readonly) BOOL hasInvalidGood;

@end

@interface WGShopCartPrice : JHObject

@property (nonatomic, strong) NSString *deliveryPrice;

@property (nonatomic, strong) NSString *totalePrice;

@end
