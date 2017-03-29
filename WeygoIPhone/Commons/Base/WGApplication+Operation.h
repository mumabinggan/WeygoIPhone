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

@property (nonatomic, strong, readonly) NSString *sessionKey;

//User Info
- (BOOL)isLogined;

- (BOOL)isBoy;

- (BOOL)isGirl;

- (NSString *)userAvatar;

- (NSString *)userName;

- (void)setName:(NSString *)name;        //名
- (void)setSurname:(NSString *)surname;
- (void)setSex:(int)sex;
- (void)setTax:(NSString *)tax;
- (void)setEmail:(NSString *)email;
- (void)setMobile:(NSString *)mobile;
- (void)setBirth:(NSString *)birth;

//Local Shop Cart
- (void)addGoodToLocalCart:(WGGoodInLocalCart *)good;

- (NSArray *)getGoodsInLocalCart;

- (void)cleanLocalCart;

@end

@interface WGApplication (OperationBaseService)

@property (nonatomic, strong, readonly) NSArray *postcodes;

- (BOOL)supportCurrentPostCode;

- (BOOL)supportPostcode:(NSString *)postCode;

@end
