//
//  WGCheckFailureProductsResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGCheckFailureProductsData;

@interface WGCheckFailureProductsResponse : WGResponse

@property (nonatomic, strong) WGCheckFailureProductsData *data;

@end

@interface WGCheckFailureProductsData : JHObject

@property (nonatomic, strong) NSString *tip;

@end
