//
//  WGCoupon.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGCoupon : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger residueCount;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *briefDescription;

@property (nonatomic, strong) NSString *couponCode;

@property (nonatomic, strong) NSString *time;

//for self use
@property (nonatomic, assign) BOOL isSelected;

@end
