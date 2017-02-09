//
//  WGHomeSlider.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeSlider.h"
#import "WGTopicItem.h"
#import "WGClassifyItem.h"

@implementation WGHomeSlider

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"topics" isEqualToString:propertyName]) {
        return [WGTopicItem class];
    }
    if ([@"classifys" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    return nil;
}

@end
