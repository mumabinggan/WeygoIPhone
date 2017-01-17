//
//  WGShopCart.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGShopCart : WGObject

@property (nonatomic, assign) float deliveryPrice;

@property (nonatomic, assign) float totalePrice;

@property (nonatomic, strong) NSArray *goods;

@end
