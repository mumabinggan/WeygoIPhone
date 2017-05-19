//
//  WGBindUnRegisteredRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRegisterRequest.h"

@interface WGBindUnRegisteredRequest : WGRegisterRequest

@property (nonatomic, strong) NSString *uniqueId;

@property (nonatomic, assign) WGThirdPartyLoginType type;

@end
