//
//  WGAddGoodToCartRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGAddGoodToCartRequest : WGGuestRequest

@property (nonatomic, strong) NSString *goodId;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSString *cap;

@end
