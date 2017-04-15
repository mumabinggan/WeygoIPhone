//
//  WGSpecialClassifyViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSpecialClassifyViewController+Request.h"
#import "WGHomeTabContentRequest.h"
#import "WGHomeTabContentResponse.h"

@implementation WGSpecialClassifyViewController (Request)

- (void)loadSpecailClassify {
    WGHomeTabContentRequest *request = [[WGHomeTabContentRequest alloc] init];
    request.menuId = self.id;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
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
