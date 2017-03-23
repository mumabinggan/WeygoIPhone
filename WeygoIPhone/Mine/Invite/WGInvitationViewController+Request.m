//
//  WGInvitationViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGInvitationViewController+Request.h"
#import "WGInvitationRequest.h"
#import "WGInvitationResponse.h"
#import "WGInvitationDescriptionRequest.h"
#import "WGInvitationDescriptionResponse.h"

@implementation WGInvitationViewController (Request)

- (void)loadInvitationDescription {
    WGInvitationDescriptionRequest *request = [[WGInvitationDescriptionRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGInvitationDescriptionResponse class] success:^(JHResponse *response) {
        [weakSelf handleInvitationDescriptionResponse:(WGInvitationDescriptionResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleInvitationDescriptionResponse:(WGInvitationDescriptionResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadInvitationRequest {
    WGInvitationRequest *request = [[WGInvitationRequest alloc] init];
    request.email = _emailTextField.text;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGInvitationResponse class] success:^(JHResponse *response) {
        [weakSelf handleInvitationResponse:(WGInvitationResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleInvitationResponse:(WGInvitationResponse *)response {
    if (response.success) {
        __weak WGInvitationViewController *weakSelf = self;
        [self showWarningMessage:response.message onCompletion:^(void) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
