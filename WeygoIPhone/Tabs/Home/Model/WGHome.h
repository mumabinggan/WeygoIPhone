//
//  WGHome.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@class WGNews;

@interface WGHome : WGObject

@property (nonatomic, assign) long long expiredTime;

@property (nonatomic, strong) NSArray *carouselFigures;

@property (nonatomic, strong) NSArray *topics;

@property (nonatomic, strong) WGNews *news;

@property (nonatomic, strong) NSArray *floors;

//for self use
@property (nonatomic, assign, readonly) float homeCarouselFiguresHeight;

@property (nonatomic, assign, readonly) float homeTopicsHeight;

@property (nonatomic, assign, readonly) float homeNewsHeight;

@property (nonatomic, strong) NSArray *carouselFiguresPictureArray;

@end
