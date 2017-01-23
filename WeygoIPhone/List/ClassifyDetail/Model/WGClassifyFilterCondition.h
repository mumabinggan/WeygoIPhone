//
//  WGClassifyFilterCondition.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGClassifyFilterCondition : WGObject

//品牌 id
@property (nonatomic, strong) NSArray *keyWordArray;

//种类
@property (nonatomic, strong) NSArray *classifyArray;

- (BOOL)hasSelected;

@end
