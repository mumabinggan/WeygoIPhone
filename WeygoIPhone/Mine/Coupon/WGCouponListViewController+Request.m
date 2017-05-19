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

- (void)loadCouponList {
    WGCouponListRequest *request = [[WGCouponListRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCouponListResponse class] success:^(JHResponse *response) {
        [weakSelf handleCouponListResponse:(WGCouponListResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf handleCouponListResponse:nil];
    }];
}

- (void)handleCouponListResponse:(WGCouponListResponse *)response {
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        [_dataMArray addObjectsFromArray:response.data];
        BOOL isCouponCode = YES;
        if (self.coupon) {
            for (WGCoupon *item in _dataMArray) {
                if (item.id == self.coupon.id) {
                    item.isSelected = !item.isSelected;
                    isCouponCode = NO;
                }
                else {
                    item.isSelected = NO;
                }
            }
        }
        if (self.coupon) {
            _inputTextField.text = self.coupon.couponCode;
            _activateBtn.selected = YES;
            _inputTextField.enabled = isCouponCode;
            _activateBtn.userInteractionEnabled = YES;
        }
        else {
            _inputTextField.text = nil;
            _inputTextField.enabled = YES;
            _activateBtn.selected = NO;
            _activateBtn.userInteractionEnabled = YES;
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUseCoupon:(WGCoupon *)coupon remove:(BOOL)remove {
    WGActiveCouponRequest *request = [[WGActiveCouponRequest alloc] init];
    request.couponCode = (coupon.id == 0) ? coupon.couponCode : nil;
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
        if (remove) {
            _inputTextField.enabled = YES;
            _inputTextField.text = nil;
            _activateBtn.selected = NO;
            _activateBtn.userInteractionEnabled = YES;
            for (WGCoupon *item in _dataMArray) {
                item.isSelected = NO;
            }
            if (self.onUse) {
                self.onUse(nil, response.data.price);
            }
        }
        else {
            BOOL isCouponCode = YES;
            for (WGCoupon *item in _dataMArray) {
                if (response.data.coupon.id == item.id) {
                    isCouponCode = NO;
                }
            }
            if (isCouponCode) {
                _inputTextField.text = coupon.couponCode;
                _activateBtn.selected = YES;
                _inputTextField.enabled = YES;
                _activateBtn.userInteractionEnabled = YES;
                for (WGCoupon *item in _dataMArray) {
                    item.isSelected = NO;
                }
                if (self.onUse) {
                    self.onUse(response.data.coupon, response.data.price);
                }
            }
            else {
                _inputTextField.text = coupon.couponCode;
                _activateBtn.selected = YES;
                _inputTextField.enabled = NO;
                _activateBtn.userInteractionEnabled = NO;
                for (WGCoupon *item in _dataMArray) {
                    if (response.data.coupon.id == item.id) {
                        item.isSelected = YES;
                    }
                    else {
                        item.isSelected = NO;
                    }
                }
                if (self.onUse) {
                    self.onUse(response.data.coupon, response.data.price);
                }
            }
        }
        [self refreshUI];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
