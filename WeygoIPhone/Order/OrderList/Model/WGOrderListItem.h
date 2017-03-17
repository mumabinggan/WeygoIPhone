//
//  WGOrderListItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGOrderGoodItem.h"

@interface WGOrderListItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, assign) float deliverPrice;

@property (nonatomic, assign) float totalPrice;

@end
