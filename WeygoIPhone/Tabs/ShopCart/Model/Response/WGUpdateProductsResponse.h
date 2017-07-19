//
//  WGUpdateProductsResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGShopCart.h"

@interface WGUpdateProductsResponse : WGResponse

@property (nonatomic, strong) WGShopCart *data;

@end
