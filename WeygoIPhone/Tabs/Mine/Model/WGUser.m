//
//  WGUser.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGUser.h"

@implementation WGUser

- (NSString *)sexString {
    return [self sexs][_sex];
}

- (NSArray *)sexs {
    return @[kStr(@"PersonInfo_Sex_Select"), kStr(@"PersonInfo_Sex_Man"), kStr(@"PersonInfo_Sex_Woman")];
}

- (NSString *)userAvatar {
    if (_sex == 1) {
        return @"slider_boy";
    }
    else if (_sex == 2) {
        return @"slider_girl";
    }
    else {
        return @"slider_unknown";
    }
}

- (BOOL)isMan {
    return (_sex == 1);
}

@end
