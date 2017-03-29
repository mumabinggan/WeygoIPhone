//
//  WGGoodDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetail.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGCarouselFigureItem.h"

@implementation WGGoodDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"carouselFigures" isEqualToString:propertyName]) {
        return [WGCarouselFigureItem class];
    }
    if ([@"productDes" isEqualToString:propertyName]) {
        return [WGGoodDetailDesItem class];
    }
    if ([@"recommendProduce" isEqualToString:propertyName]) {
        return [WGHomeFloorContentGoodItem class];
    }
    return [super classForArray:propertyName];
}

- (NSArray *)carouselFiguresPictureArray {
    if (!_carouselFigures) {
        return nil;
    }
    
    NSMutableArray *pictureArray = [NSMutableArray array];
    for (WGCarouselFigureItem *item in _carouselFigures) {
        [pictureArray addObject:[NSString safeString:item.pictureURL]];
    }
    return pictureArray;
}

- (long long)favoritedId {
    return _hasFavorited;
}

@end

@implementation WGGoodDetailDesItem

@end
