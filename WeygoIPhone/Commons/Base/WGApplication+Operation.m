//
//  WGApplication+Operation.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Operation.h"

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

@end
