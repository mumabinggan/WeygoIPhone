//
//  WGClassifyFilter.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyFilter.h"

@implementation WGClassifyFilter

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"keyWordIds" isEqualToString:propertyName]) {
        return [NSNumber class];
    }
    if ([@"classifyIds" isEqualToString:propertyName]) {
        return [NSNumber class];
    }
    return nil;
}

@end
