//
//  WGOrderGoodItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorContentGoodItem.h"

@interface WGOrderGoodItem : WGHomeFloorContentGoodItem

@property (nonatomic, assign) NSInteger goodCount; //购买数量

@property (nonatomic, strong) NSString *orderCurrentPrice;

@property (nonatomic, strong) NSString *orderPrice;

@property (nonatomic, strong) NSString *orderReducePrice;

@end
