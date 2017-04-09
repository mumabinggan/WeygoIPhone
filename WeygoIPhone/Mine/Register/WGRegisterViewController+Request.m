//
//  WGRegisterViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRegisterViewController+Request.h"
#import "WGRegisterRequest.h"
#import "WGRegisterResponse.h"

@implementation WGRegisterViewController (Request)

- (void)loadRegister {
    WGRegisterRequest *request = [[WGRegisterRequest alloc] init];
    request.username = _mobileTextField.text;
    request.verifyCode = _codeTextField.text;
    request.password = _passwordTextField.text;
    request.confirmPassword = _confirmPasswordTextField.text;
    request.firstname = _nameTextField.text;
    request.lastname = _surnameTextField.text;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGRegisterResponse class] success:^(JHResponse *response) {
        [weakSelf handleRegisterResponse:(WGRegisterResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleRegisterResponse:(WGRegisterResponse *)response {
    if (response.success) {
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [self sendNotification:WGRefreshNotificationTypeLogin];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
