//
//  WGCommitOrderUpdateTimeResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGOrderExpireGood.h"

@class WGCommitOrderUpdateTimeData;

@interface WGCommitOrderUpdateTimeResponse : WGResponse

@property (nonatomic, strong) WGCommitOrderUpdateTimeData *data;

@end

@interface WGCommitOrderUpdateTimeData : WGObject

@property (nonatomic, strong) WGOrderExpireGood *expireGood;

@end
