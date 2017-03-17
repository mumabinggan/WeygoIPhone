//
//  WGGoodDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGGoodDetail : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSArray *carouselFigures;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) float currentPrice;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) int inStock;//	int	有无货(1,有货;0,无货) ;

@property (nonatomic, strong) NSArray *productDes;

@property (nonatomic, strong) NSString *productInfo;

@property (nonatomic, strong) NSString *deliveryInfo;

@property (nonatomic, strong) NSString *commodityInfo;

@property (nonatomic, strong) NSArray *recommendProduce;

@property (nonatomic, assign) BOOL hasFavorited;

//for self use
@property (nonatomic, strong, readonly) NSArray *carouselFiguresPictureArray;

@end

@interface WGGoodDetailDesItem : WGObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *value;

@end
