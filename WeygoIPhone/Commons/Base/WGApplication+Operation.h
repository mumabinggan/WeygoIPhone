//
//  WGApplication+Operation.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"

@class WGGoodInLocalCart;

@interface WGApplication (Operation)

@property (nonatomic, strong, readonly) NSString *sessionId;

@property (nonatomic, strong, readonly) NSArray *postCodes;

@property (nonatomic, strong) NSString *currentPostCode;

@property (nonatomic, strong) WGUser *user;

//User Info
- (BOOL)isLogined;

- (BOOL)isBoy;

- (BOOL)isGirl;

- (NSString *)userAvatar;

- (NSString *)userName;


//Local Shop Cart
- (void)addGoodToLocalCart:(WGGoodInLocalCart *)good;

- (NSArray *)getGoodsInLocalCart;

- (void)cleanLocalCart;

@end