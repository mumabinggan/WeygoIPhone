//
//  WGBindRegisteredAccountRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginRequest.h"

@interface WGBindRegisteredRequest : WGLoginRequest

@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) NSString *uniqueId;

@property (nonatomic, assign) WGThirdPartyLoginType type;

@end
