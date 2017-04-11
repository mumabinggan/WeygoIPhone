//
//  WGIntegrationDetailRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGIntegrationDetailRequest : WGGuestRequest

@property (nonatomic, assign) long long pageId;

@property (nonatomic, assign) long long pageSize;

@end
