//
//  WGBaseServiceResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGBaseServiceInfo.h"

@interface WGBaseServiceResponse : WGResponse

@property (nonatomic, strong) WGBaseServiceInfo *data;

@end
