//
//  WGSearchRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGSearchRequest : WGRequest

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int pageId;

@property (nonatomic, assign) int pageSize;

@end
