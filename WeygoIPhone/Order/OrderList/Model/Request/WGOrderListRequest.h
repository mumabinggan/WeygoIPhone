//
//  WGOrderListRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

typedef NS_ENUM(NSInteger, WGOrderListType) {
    WGOrderListTypeAll = 1,
    WGOrderListTypeDelivering
};

@interface WGOrderListRequest : WGGuestRequest

@property (nonatomic, assign) WGOrderListType type;

@property (nonatomic, assign) long long pageId;

@property (nonatomic, assign) long long pageSize;

@end
