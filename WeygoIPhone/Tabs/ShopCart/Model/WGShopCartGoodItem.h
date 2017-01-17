//
//  WGShopCartGoodItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGShopCartGoodItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *briefDescription;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) float reducePrice;

@property (nonatomic, assign) float currentPrice;

@property (nonatomic, assign) NSInteger goodCount;

@property (nonatomic, assign) BOOL isInvalid;

@end
