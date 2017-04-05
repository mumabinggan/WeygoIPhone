//
//  WGChangePasswordRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGChangePasswordRequest : WGRequest

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *verifyCode;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *confirmPassword;

@end
