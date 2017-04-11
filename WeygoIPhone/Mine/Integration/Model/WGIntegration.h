//
//  WGIntegration.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGIntegration : WGObject

@property (nonatomic, assign) long long totalCount;

@property (nonatomic, assign) long long currentCanUseCount;

@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *tip;

@property (nonatomic, assign) BOOL isSelected;

@end
