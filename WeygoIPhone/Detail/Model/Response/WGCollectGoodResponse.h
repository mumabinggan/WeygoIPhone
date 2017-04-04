//
//  WGCollectGoodResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGCollectData;

@interface WGCollectGoodResponse : WGResponse

@property (nonatomic, strong) WGCollectData *data;

@end

@interface WGCollectData : WGObject

@property (nonatomic, assign) long long favoriteId;

@end
