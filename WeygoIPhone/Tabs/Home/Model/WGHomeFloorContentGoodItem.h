//
//  WGHomeFloorContentGoodItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorBaseContentItem.h"

@interface WGHomeFloorContentGoodItem : WGHomeFloorBaseContentItem

@property (nonatomic, strong) NSString *chineseName;

@property (nonatomic, strong) NSString *briefDescription;

@property (nonatomic, assign) float rating;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *reducePrice;

@property (nonatomic, strong) NSString *currentPrice;

@property (nonatomic, strong) NSString *specification;  //规格

@property (nonatomic, strong) NSString *expiredTime;

//@property (nonatomic, assign) float discount;
@property (nonatomic, strong) NSString *discount;

@property (nonatomic, assign) long long favoriteId;

@property (nonatomic, assign) int inStock;  //int	有无货(1,有货;0,无货) ;

//for self use
@property (nonatomic, assign) BOOL hasDiscount;

@end
