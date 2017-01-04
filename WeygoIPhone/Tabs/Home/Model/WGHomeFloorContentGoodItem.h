//
//  WGHomeFloorContentGoodItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorBaseContentItem.h"

@interface WGHomeFloorContentGoodItem : WGHomeFloorBaseContentItem

@property (nonatomic, strong) NSString *briefDescription;

@property (nonatomic, assign) float rating;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) float reducePrice;

@property (nonatomic, assign) float currentPrice;

@property (nonatomic, assign) float discount;

@end
