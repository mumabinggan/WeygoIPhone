//
//  WGClassifyFilterCondition.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyFilterCondition.h"
#import "WGClassifyItem.h"
#import "WGClassifyKeyword.h"

@implementation WGClassifyFilterCondition

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"keyWordArray" isEqualToString:propertyName]) {
        return [WGClassifyKeyword class];
    }
    if ([@"classifyArray" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    return nil;
}

- (BOOL)hasSelected {
    for (WGClassifyKeyword *keyword in _keyWordArray) {
        if (keyword.isSelected) {
            return YES;
        }
    }
    for (WGClassifyItem *item in _classifyArray) {
        if (item.isSelected) {
            return YES;
        }
    }
    return NO;
}

@end
