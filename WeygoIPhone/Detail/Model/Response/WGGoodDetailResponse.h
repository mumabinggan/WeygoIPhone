//
//  WGGoodDetailResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGGoodDetail.h"

@interface WGGoodDetailResponse : WGResponse

@property (nonatomic, strong) WGGoodDetail *data;

@end
