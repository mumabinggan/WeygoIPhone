//
//  WGLoginViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginViewController+Request.h"
#import "WGImageVerificationCodeResponse.h"
#import "WGLoginRequest.h"
#import "WGLoginResponse.h"

@implementation WGLoginViewController (Request)

- (void)requestVerificationCode {

}

- (void)handleVerificationCodeResponse:(WGImageVerificationCodeResponse *)response {
    if (response.success) {
        [self refreshkVerificationCode];
//        if (self.successBlock) {
//            self.successBlock(self);
//        }
    }
}

- (void)requestLogin:(WGLoginRequest *)request {
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGLoginResponse class] success:^(JHResponse *response) {
        [weakSelf handleLoginResponse:(WGLoginResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleLoginResponse:(WGLoginResponse *)response {
    if (response.success) {
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [self sendNotification:WGRefreshNotificationTypeLogin];
        if (self.successBlock) {
            self.successBlock(self);
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
