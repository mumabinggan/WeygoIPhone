//
//  WGHomeFloorContent.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGHomeFloorBaseContentItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *pictureURL;

//for dif skip
@property (nonatomic, assign) int requestParameter;

@end
