//
//  WGShopCartResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGShopCart.h"

@interface WGShopCartResponse : WGResponse

@property (nonatomic, strong) WGShopCart *data;

@end
