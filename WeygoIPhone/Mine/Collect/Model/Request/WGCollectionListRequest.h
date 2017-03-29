//
//  WGCollectionListRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGCollectionListRequest : WGGuestRequest

@property (nonatomic, assign) long long pageId;

@property (nonatomic, assign) int pageSize;

@end
