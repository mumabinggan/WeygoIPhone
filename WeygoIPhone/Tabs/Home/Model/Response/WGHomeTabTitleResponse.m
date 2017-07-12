//
//  WGHomeTabTitleResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabTitleResponse.h"
#import "WGTitleItem.h"

@implementation WGHomeTabTitleResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGTitleItem class];
    }
    return [super classForArray:propertyName];
}

- (BOOL)titlesEqual:(WGHomeTabTitleResponse *)response {
    if (response == nil) {
        return NO;
    }
    if (_data == nil && response.data == nil) {
        return YES;
    }
    if (_data.count != response.data.count) {
        return NO;
    }
    for (int num = 0; num < _data.count; ++num) {
        WGTitleItem *originItem = _data[num];
        WGTitleItem *srcItem = response.data[num];
        // || ![originItem.name isEqualToString:srcItem.name]
        if (originItem.id != srcItem.id) {
            return NO;
        }
    }
    return YES;
}

- (void)setTitles:(WGHomeTabTitleResponse *)response {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    for (WGTitleItem *item in _data) {
        if (item.data != nil) {
            [dataDic setObject:item.data forKey:@(item.id)];
        }
    }
    _data = response.data;
    for (WGTitleItem *item in _data) {
        item.data = [dataDic objectForKey:@(item.id)];
    }
}

@end
