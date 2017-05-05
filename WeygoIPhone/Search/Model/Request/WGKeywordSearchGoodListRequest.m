//
//  WGKeywordSearchGoodListRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGKeywordSearchGoodListRequest.h"

@implementation WGKeywordSearchGoodListRequest

- (id)init {
    self = [super init];
    if (self) {
        _pageSize = 15;
    }
    return self;
}

- (NSString *)api {
    return @"catalogSearch/suggest?";
}

@end
