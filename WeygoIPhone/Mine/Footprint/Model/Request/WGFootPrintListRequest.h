//
//  WGFootPrintListRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGFootPrintListRequest : WGGuestRequest

@property (nonatomic, assign) long long pageId;

@property (nonatomic, assign) int pageSize;

@end
