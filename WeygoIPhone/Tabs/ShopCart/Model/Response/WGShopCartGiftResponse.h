//
//  WGShopCartGiftResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGShopCartGiftData;

@interface WGShopCartGiftResponse : WGResponse

@property (nonatomic, strong) WGShopCartGiftData *data;

@end

@interface WGShopCartGiftData : JHObject

@property (nonatomic, strong) NSString *tip;

@property (nonatomic, strong) NSArray *goods;

@end
