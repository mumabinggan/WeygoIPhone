//
//  WGGetUserInfoResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/27.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGUser.h"

@interface WGGetUserInfoResponse : WGResponse

@property (nonatomic, strong) WGUser *data;

@end
