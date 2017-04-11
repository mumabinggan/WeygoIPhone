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
#import "WGCoupon.h"

@implementation WGCouponListViewController (Request)

- (void)loadListResponse:(BOOL)refresh pulling:(BOOL)pulling {
    WGCouponListRequest *request = [[WGCouponListRequest alloc] init];
    request.pageId = (refresh) ? 0 : _dataMArray.count;
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
        if (refresh) {
            [_dataMArray removeAllObjects];
        }
        [_dataMArray addObjectsFromArray:response.data];
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUseCoupon:(WGCoupon *)coupon remove:(BOOL)remove {
    WGActiveCouponRequest *request = [[WGActiveCouponRequest alloc] init];
    request.couponCode = (coupon.isCouponCode) ? coupon.couponCode : nil;
    request.couponId = coupon.id;
    request.remove = remove;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGActiveCouponResponse class] success:^(JHResponse *response) {
        [weakSelf handleActiveCouponListResponse:(WGActiveCouponResponse *)response coupon:coupon remove:remove];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleActiveCouponListResponse:(WGActiveCouponResponse *)response coupon:(WGCoupon *)coupon remove:(BOOL)remove {
    if (response.success) {
        if (coupon.isCouponCode) {
            for (WGCoupon *item in _dataMArray) {
                item.isSelected = NO;
            }
            _activateBtn.selected = !remove;
            if (self.onUse) {
                self.onUse(coupon, response.data.price);
            }
            if (!remove) {
                [self showWarningMessage:response.message onCompletion:^() {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }
        else {
            for (WGCoupon *item in _dataMArray) {
                if (item.id == coupon.id) {
                    item.isSelected = !item.isSelected;
                    break;
                }
            }
            if (self.onUse) {
                self.onUse(coupon, response.data.price);
            }
            if (!remove) {
                _activateBtn.selected = NO;
                [self showWarningMessage:response.message onCompletion:^() {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
