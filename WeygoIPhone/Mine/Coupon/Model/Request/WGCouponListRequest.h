//
//  WGCouponListRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGCouponListRequest : WGRequest

@property (nonatomic, assign) long long pageId;

@property (nonatomic, assign) long long pageSize;

@end
