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

- (NSString *)sessionKey {
    return [self user].sectionKey;
}

- (NSString *)currentPostCode {
    return self.user.cap;
}

- (BOOL)isLogined {
    return ([self user] != nil);
}

- (BOOL)isBoy {
    if ([self user]) {
        return ([self user].sex == 1);
    }
    return NO;
}

- (BOOL)isGirl {
    if (self.user) {
        return (self.user.sex == 2);
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
    if ([self user]) {
        return [self user].name;
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

@implementation WGApplication (OperationBaseService)

//Base Service
- (void)handleBaseService:(WGBaseServiceInfo *)baseServiceInfo {
    _baseServiceInfo = baseServiceInfo;
}

- (NSArray *)postcodes {
    if (_baseServiceInfo) {
        return _baseServiceInfo.postcodes;
    }
    return nil;
}

- (BOOL)supportCurrentPostCode {
    return [self supportPostcode:self.currentPostCode];
}

- (BOOL)supportPostcode:(NSString *)postCode {
    NSArray *postCodes = self.postcodes;
    if (postCodes) {
        return [postCodes containsObject:postCode];
    }
    return NO;
}

@end
