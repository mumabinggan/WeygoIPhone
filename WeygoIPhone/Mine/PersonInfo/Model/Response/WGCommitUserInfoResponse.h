//
//  WGCommitUserInfoResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGUser.h"

@interface WGCommitUserInfoResponse : WGResponse

@property (nonatomic, strong) WGUser *data;

@end
