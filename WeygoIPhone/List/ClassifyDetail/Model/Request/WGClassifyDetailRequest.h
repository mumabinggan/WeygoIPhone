//
//  WGClassifyDetailRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGClassifyDetailRequest : WGRequest

@property (nonatomic, assign) long long brandId;

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, assign) int pageId;

@property (nonatomic, assign) int pageSize;

@property (nonatomic, strong) NSString *order;

@property (nonatomic, strong) NSString *dir;

@end
