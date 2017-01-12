//
//  WGCarouselFigureItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

typedef NS_ENUM(NSInteger, WGCarouselFigureItemType) {
    WGCarouselFigureItemTypeNone
};

@interface WGCarouselFigureItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, assign) WGCarouselFigureItemType type;
//for dif skip
@property (nonatomic, assign) int requestParameter;

@end
