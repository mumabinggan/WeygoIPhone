//
//  WGHomeFloorContentGoodItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorContentGoodItem.h"

@implementation WGHomeFloorContentGoodItem

- (BOOL)hasDiscount {
    return ![NSString isNullOrEmpty:_discount];
}

@end
