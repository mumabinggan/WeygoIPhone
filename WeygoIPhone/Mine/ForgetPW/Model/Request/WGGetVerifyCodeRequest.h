//
//  WGGetVerifyCodeRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGGetVerifyCodeRequest : WGRequest

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *countryCode;

@end
