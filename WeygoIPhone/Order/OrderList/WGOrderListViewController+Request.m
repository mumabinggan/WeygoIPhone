//
//  WGOrderListViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListViewController+Request.h"
#import "WGOrderListRequest.h"
#import "WGOrderListResponse.h"

@implementation WGOrderListViewController (Request)

- (void)loadOrderList:(BOOL)refresh pulling:(BOOL)pulling {
    WGOrderListRequest *request = [[WGOrderListRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGOrderListResponse class] success:^(JHResponse *response) {
        [weakSelf handleOrderListResponse:(WGOrderListResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleOrderListFailResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleOrderListResponse:(WGOrderListResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (response.success) {
        
    }
    else {
        
    }
}

- (void)handleOrderListFailResponse:(WGOrderListResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    [self showWarningMessage:kStr(@"Request Failed")];
}

@end
