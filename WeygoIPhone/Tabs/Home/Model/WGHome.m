//
//  WGHome.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHome.h"
#import "WGCarouselFigureItem.h"
#import "WGTopicItem.h"
#import "WGNewsItem.h"
#import "WGHomeFloorItem.h"

@implementation WGHome

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"carouselFigures" isEqualToString:propertyName]) {
        return [WGCarouselFigureItem class];
    }
    if ([@"topics" isEqualToString:propertyName]) {
        return [WGTopicItem class];
    }
    if ([@"news" isEqualToString:propertyName]) {
        return [WGNewsItem class];
    }
    if ([@"floors" isEqualToString:propertyName]) {
        return [WGHomeFloorItem class];
    }
    return nil;
}

- (float)homeCarouselFiguresHeight {
    float height = 0.0f;
    if (_carouselFigures && _carouselFigures.count > 0) {
        height = kAppAdaptHeight(176);
    }
    return height;
}

- (float)homeTopicsHeight {
    float height = 0.0f;
    if (_topics && _topics.count > 0) {
        height = kAppAdaptHeight(116);
    }
    return height;
}

- (float)homeNewsHeight {
    float height = 0.0f;
    if (_news && _news.count > 0) {
        height = kAppAdaptHeight(48);
    }
    return height;
}

@end
