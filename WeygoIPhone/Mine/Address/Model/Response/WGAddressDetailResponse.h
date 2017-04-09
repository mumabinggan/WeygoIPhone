//
//  WGAddressDetailResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGAddress.h"

@interface WGAddressDetailResponse : WGResponse

@property (nonatomic, strong) WGAddress *data;

@end
