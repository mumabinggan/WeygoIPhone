//
//  WGBindThirdPartyViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBindThirdPartyViewController+Request.h"

@implementation WGBindThirdPartyViewController (Request)

- (void)requestVerificationCode {
    __weak id weakSelf = self;
    [[WGApplication sharedApplication] loadImageVerificationCodeOnCompletion:^(WGImageVerificationCodeResponse *response) {
        [weakSelf handleVerificationCodeResponse:response];
    }];
}

- (void)handleVerificationCodeResponse:(WGImageVerificationCodeResponse *)response {
    if (response.success) {
        [self refreshkVerificationCode];
    }
}

@end
