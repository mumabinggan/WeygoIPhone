//
//  WGBenefitTabResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBenefitTabResponse.h"
#import "WGTitleItem.h"

@implementation WGBenefitTabResponse

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"data" isEqualToString:propertyName]) {
        return [WGTitleItem class];
    }
    return [super classForArray:propertyName];
}

- (void)setTitles:(WGBenefitTabResponse *)response {
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
