//
//  WGLoginViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginViewController.h"

@interface WGLoginViewController (Request)

- (void)requestVerificationCode;

- (void)requestLogin:(WGLoginRequest *)request;

@end
