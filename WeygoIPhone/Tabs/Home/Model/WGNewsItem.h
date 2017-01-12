//
//  WGNewsItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

typedef NS_ENUM(NSInteger, WGNewsItemType) {
    WGNewsItemTypeNone
};

@interface WGNewsItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) WGNewsItemType type;
//for dif skip
@property (nonatomic, assign) int requestParameter;

@end
