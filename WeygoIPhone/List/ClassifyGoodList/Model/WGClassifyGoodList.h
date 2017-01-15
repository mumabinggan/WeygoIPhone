//
//  WGClassifyGoodList.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGClassifyGoodList : WGObject

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, strong) NSString *classifyName;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSArray *contents;

@end
