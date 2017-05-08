//
//  WGTabAsiaViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabAsiaViewController+Request.h"
#import "WGHomeTabContentRequest.h"
#import "WGHomeTabContentResponse.h"

@implementation WGTabAsiaViewController (Request)

- (void)loadAsiaClassify {
    WGHomeTabContentRequest *request = [[WGHomeTabContentRequest alloc] init];
    request.menuId = 193;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
        [weakSelf handleHomeContent:(WGHomeTabContentResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHomeContent:(WGHomeTabContentResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
