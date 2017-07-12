//
//  WGClassifyDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetail.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGClassifyItem.h"

@implementation WGClassifyDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goodArray" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    if ([@"subClassifyArray" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    if ([@"recommendedArray" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

+ (NSDictionary *)convertKeyMapper {
    return @{@"subClassifyArray" : @"subArray"};
}

- (long long)snappedUpExpiredTime {
    if (_snappedUpExpiredTime < [[NSDate new] timeIntervalSince1970]) {
        _snappedUpExpiredTime = 0;
    }
    return _snappedUpExpiredTime;
}

- (BOOL)hasNews {
    return _news != nil;
}

- (BOOL)hasCarousel {
    return _carouselFigureItem != nil;
}

@end
