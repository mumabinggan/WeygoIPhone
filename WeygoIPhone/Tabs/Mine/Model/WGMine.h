//
//  WGMine.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGUser.h"

@interface WGMine : WGObject

@property (nonatomic, strong) WGUser *user;

@property (nonatomic, assign) long long messageCount;

@property (nonatomic, assign) long long orderCount;

@property (nonatomic, assign) long long deliveryCount;

@property (nonatomic, assign) long long shopCartCount;

@end
