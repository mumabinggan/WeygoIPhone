//
//  WGOrderGoodItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorContentGoodItem.h"

@interface WGOrderGoodItem : WGHomeFloorContentGoodItem

@property (nonatomic, assign) NSInteger number; //购买数量

@property (nonatomic, assign) float orderCurrentPrice;

@property (nonatomic, assign) float orderPrice;

@property (nonatomic, assign) float orderReducePrice;

@end
