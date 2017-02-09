//
//  WGBaseServiceInfo.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGBaseServiceInfo : WGObject

@property (nonatomic, strong) NSArray *postcodes;           //邮编列表

@property (nonatomic, strong) NSString *currentPostCode;    //当前默认邮编

@end
