//
//  WGLoginRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCallBaseRequest.h"

@interface WGLoginRequest : WGCallBaseRequest

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *verificationcode;

@end
