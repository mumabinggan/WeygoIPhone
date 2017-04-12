//
//  WGIntegrationDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGIntegrationDetail.h"

@implementation WGIntegrationDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"history" isEqualToString:propertyName]) {
        return [WGIntegrationHistoryItem class];
    }
    return [super classForArray:propertyName];
}

- (BOOL)hasHistory {
    if (_history && _history.count) {
        return YES;
    }
    return NO;
}

@end

@implementation WGIntegrationHistoryItem

@end
