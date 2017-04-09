//
//  WGClassifyDetailFilterViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailFilterViewController+Request.h"
#import "WGClassifyDetailFilterRequest.h"
#import "WGClassifyDetailFilterResponse.h"

@implementation WGClassifyDetailFilterViewController (Request)

- (void)loadClassifyDetailFilter {
    WGClassifyDetailFilterRequest *request = [[WGClassifyDetailFilterRequest alloc] init];
    request.classifyId = self.classifyId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGClassifyDetailFilterResponse class] success:^(JHResponse *response) {
        [weakSelf handleClassifyDetailFilterResponse:(WGClassifyDetailFilterResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClassifyDetailFilterResponse:(WGClassifyDetailFilterResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshView];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
