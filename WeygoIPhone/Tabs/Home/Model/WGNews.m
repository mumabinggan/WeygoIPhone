//
//  WGTopic.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGNews.h"
#import "WGNewsItem.h"

@implementation WGNews

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"contents" isEqualToString:propertyName]) {
        return [WGNewsItem class];
    }
    return [super classForArray:propertyName];
}

@end
