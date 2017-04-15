//
//  WGCarouselFigureItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGCarouselFigureItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, assign) WGAppJumpType jumpType;

//for dif skip
@property (nonatomic, assign) int requestParameter; //暂时没有用到

@end
