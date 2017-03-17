//
//  WGOrderDetailResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGOrderDetail.h"

@interface WGOrderDetailResponse : WGResponse

@property (nonatomic, strong) WGOrderDetail *data;

@end
