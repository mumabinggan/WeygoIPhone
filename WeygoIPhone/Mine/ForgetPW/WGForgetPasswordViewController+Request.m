//
//  WGForgetPasswordViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGForgetPasswordViewController+Request.h"
#import "WGChangePasswordRequest.h"
#import "WGChangePasswordResponse.h"

@implementation WGForgetPasswordViewController (Request)

- (void)loadGetVerificationCode {
    WeakSelf;
    [[WGApplication sharedApplication] loadVerificationCodeUserName:_mobileTextField.text countryCode:_codeTextField.text onCompletion:^(WGGetVerifyCodeResponse *response) {
        [weakSelf showWarningMessage:response.message];
    }];
}

- (void)loadChangePassword {
    WGChangePasswordRequest *request = [[WGChangePasswordRequest alloc] init];
    request.username = _mobileTextField.text;
    request.verifyCode = _codeTextField.text;
    request.password = _passwordTextField.text;
    request.confirmPassword = _confirmPasswordTextField.text;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGChangePasswordResponse class] success:^(JHResponse *response) {
        [weakSelf handleChangePasswordResponse:(WGChangePasswordResponse *)response];
    } failure:^(NSError *error) {
        [self showWarningMessage:kStr(@"Request Failed")];;
    }];
}

- (void)handleChangePasswordResponse:(WGChangePasswordResponse *)response {
    if (response.success) {
        WeakSelf;
        [self showWarningMessage:response.message onCompletion:^(void) {
            [weakSelf handleChangeSuccess];
        }];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)handleChangeSuccess {
    [self sendNotification:WGRefreshNotificationTypeLogout];
    [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
    [self openLoginViewController];
}

@end
