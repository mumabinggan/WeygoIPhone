//
//  WGLoginViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginViewController+Request.h"
#import "WGImageVerificationCodeResponse.h"

@implementation WGLoginViewController (Request)

- (void)requestVerificationCode {

}

- (void)handleVerificationCodeResponse:(WGImageVerificationCodeResponse *)response {
    if (response.success) {
        [self refreshkVerificationCode];
    }
}

- (void)requestLogin:(WGLoginRequest *)request {
    
}

@end
