//
//  WGCouponListViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCouponListViewController+Request.h"
#import "WGCouponListRequest.h"
#import "WGCouponListResponse.h"
#import "WGActiveCouponRequest.h"
#import "WGActiveCouponResponse.h"

@implementation WGCouponListViewController (Request)

- (void)loadListResponse:(BOOL)refresh pulling:(BOOL)pulling {
    WGCouponListRequest *request = [[WGCouponListRequest alloc] init];
    request.pageId = (refresh) ? 0 : _dataArray.count;
    request.pageSize = 15;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCouponListResponse class] success:^(JHResponse *response) {
        [weakSelf handleCouponListResponse:(WGCouponListResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleCouponListResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleCouponListResponse:(WGCouponListResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        _dataArray = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
