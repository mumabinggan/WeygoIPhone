//
//  WGRegisterRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGRegisterRequest : WGRequest

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *cap;

@property (nonatomic, strong) NSString *verifyCode; //不是必须

@property (nonatomic, strong) NSString *confirmPassword;

@property (nonatomic, strong) NSString *firstname;

@property (nonatomic, strong) NSString *lastname;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *countryCode;    //国家code(+39默认, +86)

@end
