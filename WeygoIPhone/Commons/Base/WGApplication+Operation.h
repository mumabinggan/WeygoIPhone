//
//  WGApplication+Operation.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "WGSearchKeywordItem.h"

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

- (void)setCurrentPostCode:(NSString *)currentPostCode;

- (void)reset;

@end

@interface WGApplication (OperationBaseService)

@property (nonatomic, strong, readonly) NSArray *postcodes;

- (BOOL)supportCurrentPostCode;

- (BOOL)supportPostcode:(NSString *)postCode;

@end

@interface WGApplication (AddShopCartAnimation)

- (void)addShopToCart:(NSString *)imageURL fromPoint:(CGPoint)fromPoint;

- (void)addShopToCartImage:(NSString *)imageString fromPoint:(CGPoint)fromPoint;

- (void)addShopToTabCart:(NSString *)imageURL fromPoint:(CGPoint)fromPoint;

@end

@interface WGApplication (ShopCart)

- (void)increaseGoodCount:(NSInteger)increaseCount;

- (void)decreaseGoodCount:(NSInteger)decreaseCount;

- (void)handleShopCartGoodCount:(NSInteger)count;

@end

@interface WGApplication (Language)

- (void)setLanguage:(int)language;

@end

@interface WGApplication (RequestSign)

- (NSString *)sign:(NSDictionary *)dictionary;

- (NSString *)payUrl:(NSString *)url;

- (NSString *)paySign;

@end

@interface WGApplication (Search)

- (NSArray*)getLocalSettingHistorySearchArray;

- (void)addLocalSettingHistorySearch:(WGSearchKeywordItem *)searchInfo;

- (void)cleanLocalSettingHistorySearch;

- (void)cleanLocalSettingHistorySearch:(NSString *)name;

@end
