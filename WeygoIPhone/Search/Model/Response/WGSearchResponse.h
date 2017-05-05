//
//  WGSearchResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
@class WGSearchData;

@interface WGSearchResponse : WGResponse

@property (nonatomic, strong) WGSearchData *data;

@end

@interface WGSearchData : WGObject

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *keywords;

@end
