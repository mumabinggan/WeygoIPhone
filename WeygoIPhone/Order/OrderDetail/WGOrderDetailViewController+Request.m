//
//  WGOrderDetailViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderDetailViewController+Request.h"
#import "WGOrderDetailResponse.h"
#import "WGOrderDetailRequest.h"

@implementation WGOrderDetailViewController (Request)

- (void)loadOrderDetail {
    WGOrderDetailRequest *request = [[WGOrderDetailRequest alloc] init];
    request.id = self.orderId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGOrderDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleOrderDetailResponse:(WGOrderDetailResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleOrderDetailResponse:(WGOrderDetailResponse *)response {
    if (response.success) {
        _orderDetail = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
