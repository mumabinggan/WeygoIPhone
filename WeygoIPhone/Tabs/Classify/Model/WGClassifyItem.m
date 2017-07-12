//
//  WGClassifyItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyItem.h"
#import "WGClassifyHotGoodItem.h"

@implementation WGClassifyItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"subArray" isEqualToString:propertyName]) {
        return [WGClassifyItem class];
    }
    if ([@"goodArray" isEqualToString:propertyName]) {
        return [WGClassifyHotGoodItem class];
    }
    return [super classForArray:propertyName];
}

+ (NSArray *)ignoredProperties {
    return @[@"allArray"];
}

- (NSArray *)allArray {
    WGClassifyItem *totalItem = [[WGClassifyItem alloc] init];
    totalItem.id = _id;
    totalItem.name = kStr(@"Slider_All");
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:totalItem];
    [array addObjectsFromArray:_subArray];
    return array;
}

@end
