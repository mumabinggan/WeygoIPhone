//
//  WGOrderExpireGood.h
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGOrderExpireGood : WGObject

@property (nonatomic, strong) NSString *tips;

@property (nonatomic, strong) NSArray *goods;

//self use
@property (nonatomic, assign) BOOL canChangeTime;

@end
