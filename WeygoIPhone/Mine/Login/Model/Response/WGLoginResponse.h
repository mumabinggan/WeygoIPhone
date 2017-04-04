//
//  WGLoginResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGUser.h"

@interface WGLoginResponse : WGResponse

@property (nonatomic, strong) WGUser *data;

@end
