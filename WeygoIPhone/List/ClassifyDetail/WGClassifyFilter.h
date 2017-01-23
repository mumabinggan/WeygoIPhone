//
//  WGClassifyFilter.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGClassifyFilter : WGObject

//品牌 id
@property (nonatomic, assign) NSArray *keyWordIds;

//种类
@property (nonatomic, assign) NSArray *classifyIds;

@end
