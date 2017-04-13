//
//  WGClassifyDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGNews.h"

@class WGCarouselFigureItem;

@interface WGClassifyDetail : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) WGCarouselFigureItem *carouselFigureItem;

@property (nonatomic, strong) NSArray *subClassifyArray;

@property (nonatomic, strong) NSArray *goodArray;

// 促销
@property (nonatomic, strong) NSArray *recommendedArray;

//消息
@property (nonatomic, strong) WGNews *news;

@end
