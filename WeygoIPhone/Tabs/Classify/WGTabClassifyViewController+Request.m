//
//  WGTabClassifyViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabClassifyViewController+Request.h"
#import "WGClassifyRequest.h"
#import "WGClassifyResponse.h"
#import "WGClassifyItem.h"

@implementation WGTabClassifyViewController (Request)

- (void)loadClassify {
    if (_data) {
        [self refreshUI];
    }
    WGClassifyRequest *request = [[WGClassifyRequest alloc] init];
    request.is_hot = 1;
    if (_data) {
        request.showsLoadingView = NO;
    }
    WeakSelf;
    [self get:request forResponseClass:[WGClassifyResponse class] success:^(JHResponse *response) {
        [weakSelf handleClassifyResponse:(WGClassifyResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClassifyResponse:(WGClassifyResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
