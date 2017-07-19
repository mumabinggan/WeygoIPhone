//
//  WGBindThirdPartyViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBindThirdPartyViewController+Request.h"
#import "WGBindRegisteredRequest.h"
#import "WGBindRegisteredResponse.h"
#import "WGBindUnRegisteredRequest.h"
#import "WGBindUnRegisteredResponse.h"

@implementation WGBindThirdPartyViewController (Request)

- (void)loadBindUnRegister {
    WGBindUnRegisteredRequest *request = [[WGBindUnRegisteredRequest alloc] init];
    request.type = self.type;
    request.uniqueId = self.uniqueId;
    request.username = _mobileTextField.text;
    request.verifyCode = _unRegisterCodeTextField.text;
    request.password = _unRegisterPasswordTextField.text;
    request.confirmPassword = _confirmPasswordTextField.text;
    request.firstname = _nameTextField.text;
    request.lastname = _surnameTextField.text;
    request.email = _emailTextField.text;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGBindUnRegisteredResponse class] success:^(JHResponse *response) {
        [weakSelf handleBindUnRegisterResponse:(WGBindUnRegisteredResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleBindUnRegisterResponse:(WGBindUnRegisteredResponse *)response {
    if (response.success) {
        [[WGEvent shareInstance] registerCompletion:@(response.data.userId).stringValue from:(self.type == WGThirdPartyLoginTypeWechat) ? kRegisterCompletionFromWeChat : kRegisterCompletionFromFacebook];
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [self sendNotification:WGRefreshNotificationTypeLogin];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogIn object:nil];
        [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadBindRegister {
    WGBindRegisteredRequest *request = [[WGBindRegisteredRequest alloc] init];
    request.uniqueId = self.uniqueId;
    request.type = self.type;
    request.account = _usernameTextField.text;
    request.password = _passwordTextField.text;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGBindRegisteredResponse class] success:^(JHResponse *response) {
        [weakSelf handleBindRegisteredResponse:(WGBindRegisteredResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleBindRegisteredResponse:(WGBindRegisteredResponse *)response {
    if (response.success) {
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [self sendNotification:WGRefreshNotificationTypeLogin];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogIn object:nil];
        [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
