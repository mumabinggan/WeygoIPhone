//
//  WGLoginRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCallBaseRequest.h"

@interface WGLoginRequest : WGRequest

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *password;

//from 购物车
//@property (nonatomic, strong) NSString *cap;

//from 购物车
//@property (nonatomic, strong) NSArray *shopCarts;

@end
