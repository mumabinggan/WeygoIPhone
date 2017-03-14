//
//  WGApplication+Operation.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Operation.h"
#import "WGGoodInLocalCart.h"

@implementation WGApplication (Operation)

- (NSString *)sessionId {
    return _sessionResponse.data;
}

- (NSArray *)postCodes {
    return _baseServiceResponse.data.postcodes;
}

- (NSString *)currentPostCode {
    return _baseServiceResponse.data.currentPostCode;
}

- (void)setCurrentPostCode:(NSString *)currentPostCode {
    _baseServiceResponse.data.currentPostCode = currentPostCode;
}

- (BOOL)isLogined {
    return ([self user] != nil);
}

- (BOOL)isBoy {
    if (_user) {
        return (_user.sex == 1);
    }
    return NO;
}

- (BOOL)isGirl {
    if (_user) {
        return (_user.sex == 2);
    }
    return NO;
}

- (NSString *)userAvatar {
    if ([self isBoy]) {
        return @"slider_boy";
    }
    else if ([self isGirl]) {
        return @"slider_girl";
    }
    else {
        return @"slider_unknown";
    }
}

- (NSString *)userName {
    if (_user) {
        return _user.name;
    }
    return nil;
}

- (WGUser *)user {
    if (!_user) {
        _user = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsKeyUser];
    }
    return _user;
}

- (void)setUser:(WGUser *)user {
    _user = user;
    if (user) {
        [[JHLocalSettings sharedSettings] setSettings:user forKey:kLocalSettingsKeyUser];
    }
    else {
        [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsKeyUser];
    }
}

- (void)reset {
    _user = nil;
    self.currentPostCode = nil;
}

- (void)addGoodToLocalCart:(WGGoodInLocalCart *)good {
    NSArray *goods = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsLocalCartGoods];
    NSMutableArray *goodMArray = [NSMutableArray array];
    for (NSData *item in goods) {
        WGGoodInLocalCart *cart = [[WGGoodInLocalCart alloc] initWithData:item error:nil];
        if (cart.id == good.id) {
            good.count += cart.count;
        }
        else {
            [goodMArray addObject:item];
        }
    }
    NSData *addData = [NSKeyedArchiver archivedDataWithRootObject:goods];
    [goodMArray addObject:addData];
    [[JHLocalSettings sharedSettings] setSettings:goodMArray forKey:kLocalSettingsLocalCartGoods];
}

- (NSArray *)getGoodsInLocalCart {
    NSArray *goods = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsLocalCartGoods];
    NSMutableArray *goodMArray = [[NSMutableArray alloc] init];
    for (NSData *item in goods) {
        WGGoodInLocalCart *good = [[WGGoodInLocalCart alloc] initWithData:item error:nil];
        if (good) {
            [goodMArray addObject:good];
        }
    }
    return goodMArray;
}

- (void)cleanLocalCart {
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsLocalCartGoods];
}

@end
