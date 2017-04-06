//
//  WGRegisterResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGUser.h"

@interface WGRegisterResponse : WGResponse

@property (nonatomic, strong) WGUser *data;

@end
