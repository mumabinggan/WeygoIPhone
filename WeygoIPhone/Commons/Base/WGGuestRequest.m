//
//  WGGuestRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@implementation WGGuestRequest

- (id)init {
    self = [super init];
    if (self) {
        _sessionKey = [WGApplication sharedApplication].user.sectionKey;
    }
    return self;
}

@end
