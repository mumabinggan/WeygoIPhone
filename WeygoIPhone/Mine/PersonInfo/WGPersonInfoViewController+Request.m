//
//  WGPersonInfoViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPersonInfoViewController+Request.h"
#import "WGUserInfoRequest.h"
#import "WGUserInfoResponse.h"
#import "WGCommitUserInfoRequest.h"
#import "WGCommitUserInfoResponse.h"

@implementation WGPersonInfoViewController (Request)

- (void)loadCommitPersonInfo {
    WGCommitUserInfoRequest *request = [[WGCommitUserInfoRequest alloc] init];
    request.firstName = _user.name;
    request.lastName = _user.surname;
    request.phone = _user.mobile;
    request.sex = _user.sex;
    request.birth = _user.birth;
    request.tax = _user.tax;
    request.email = _user.email;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCommitUserInfoResponse class] success:^(JHResponse *response) {
        [weakSelf handleCommitUserInfo:(WGCommitUserInfoResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf handleFailCommitUserInfo];
    }];
}

- (void)handleCommitUserInfo:(WGCommitUserInfoResponse *)response {
    [self stopRefreshing:_tableView refresh:YES pulling:NO];
    if (response.success) {
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)handleFailCommitUserInfo {
    [self stopRefreshing:_tableView refresh:YES pulling:NO];
    [self showWarningMessage:kStr(@"Request Failed")];
}

- (void)loadPersonInfo {
    [[WGApplication sharedApplication] loadUserInfoOnCompletion:^(WGUserInfoResponse *response) {
        if (response) {
            _user = response.data;
            [self refreshUI];
        }
    }];
}

@end
