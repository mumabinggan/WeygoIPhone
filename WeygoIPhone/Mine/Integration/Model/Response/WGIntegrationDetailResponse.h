//
//  WGIntegrationDetailResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGIntegrationDetail.h"

@interface WGIntegrationDetailResponse : WGResponse

@property (nonatomic, strong) WGIntegrationDetail *data;

@end
