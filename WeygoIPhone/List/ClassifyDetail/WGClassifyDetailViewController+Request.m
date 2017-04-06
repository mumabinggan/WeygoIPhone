//
//  WGClassifyDetailViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailViewController+Request.h"
#import "WGClassifyDetailRequest.h"
#import "WGClassifyDetailResponse.h"

@implementation WGClassifyDetailViewController (Request)

- (void)loadClassifyDetailFilter {
    WGClassifyDetailRequest *request = [[WGClassifyDetailRequest alloc] init];
    request.classifyId = self.classifyId;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGClassifyDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleClassifyDetailResponse:(WGClassifyDetailResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClassifyDetailResponse:(WGClassifyDetailResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
