//
//  WGIntegrationDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGIntegrationDetail : WGObject

@property (nonatomic, assign) long long totalCount;

@property (nonatomic, strong) NSArray *history;

@end

@interface WGIntegrationHistoryItem : WGObject

@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *integration;

@end
