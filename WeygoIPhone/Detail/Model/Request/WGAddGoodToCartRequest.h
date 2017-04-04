//
//  WGAddGoodToCartRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGAddGoodToCartRequest : WGGuestRequest

@property (nonatomic, strong) NSString *goodIds;

@property (nonatomic, strong) NSString *counts;

@property (nonatomic, strong) NSString *cap;

@end
