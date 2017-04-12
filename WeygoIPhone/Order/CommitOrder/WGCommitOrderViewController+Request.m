//
//  WGCommitOrderViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController+Request.h"
#import "WGCommitOrderRequest.h"
#import "WGCommitOrderResponse.h"
#import "WGSettlementResultRequest.h"
#import "WGSettlementResultResponse.h"
#import "WGUpdateOrderCouponRequest.h"
#import "WGUpdateOrderCouponResponse.h"
#import "WGCommitOrderDetail.h"
#import "WGPaySuccessViewController.h"
#import "WGPayWebViewController.h"

@implementation WGCommitOrderViewController (Request)

- (void)loadSettlementResultDetail {
    WGSettlementResultRequest *request = [[WGSettlementResultRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSettlementResultResponse class] success:^(JHResponse *response) {
        [weakSelf handleSettlementResultResponse:(WGSettlementResultResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleSettlementResultResponse:(WGSettlementResultResponse *)response {
    if (response.success) {
        _commitOrderDetail = [[WGCommitOrderDetail alloc] initWithSettlementResult:response.data];
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

/*
 @property (nonatomic, strong) NSString *billingCompanyName;
 @property (nonatomic, strong) NSString *billingCountry;
 @property (nonatomic, strong) NSString *billingPhone;
 @property (nonatomic, strong) NSString *billingAddress;
 @property (nonatomic, strong) NSString *billingCivico;
 @property (nonatomic, strong) NSString *billingCity;
 @property (nonatomic, strong) NSString *billingCap;
 @property (nonatomic, strong) NSString *billingProvince;
 @property (nonatomic, strong) NSString *billingTaxCode;
 //时间
 @property (nonatomic, strong) NSString *deliverDate;
 @property (nonatomic, strong) NSString *deliverTime;
 //支付
 @property (nonatomic, strong) NSString *payMethod;
 //使用积分
 @property (nonatomic, assign) int useIntegral;      //1:使用 0:不使用
 @property (nonatomic, assign) long long couponId;
 @property (nonatomic, strong) NSString *couponCode;
 @property (nonatomic, strong) NSString *comments;
 */

- (void)loadCommitOrder {
    WGCommitOrderRequest *request = [[WGCommitOrderRequest alloc] init];
    request.addressId = _commitOrderDetail.address.addressId;
    
    WGReceipt *receipt = _commitOrderDetail.receipt;
    request.useBilling = receipt ? 1 : 0;
    request.billingCompanyName = receipt.companyName;
    request.billingCountry = receipt.countryId;
    request.billingPhone = receipt.phone;
    request.billingAddress = receipt.address;
    request.billingCivico = receipt.civico;
    request.billingCity = receipt.city;
    request.billingCap = receipt.cap;
    request.billingProvince = receipt.province;
    request.billingTaxCode = receipt.taxCode;
    
    WGCommitOrderDeliverTime *time = _commitOrderDetail.deliverTime;
    request.deliverDate = time.currentDateId;
    request.deliverTime = time.currentTimeId;
    
    WGCommitOrderPay *pay = _commitOrderDetail.payMothod;
    request.payMethod = pay.currentPayId;
    
    request.comments = _commitOrderDetail.remark;
    
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCommitOrderResponse class] success:^(JHResponse *response) {
        [weakSelf handleCommitOrderResponse:(WGCommitOrderResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleCommitOrderResponse:(WGCommitOrderResponse *)response {
    if (response.success) {
        if ([NSString isNullOrEmpty:response.data.orderId]) {
            WGPaySuccessViewController *vc = [[WGPaySuccessViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            if ([NSString isNullOrEmpty:response.data.action]) {
                __weak WGCommitOrderViewController *weakSelf = self;
                [self showWarningMessage:response.message onCompletion:^(void) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
            else {
                WGPayWebViewController *vc = [[WGPayWebViewController alloc] initWithOrderData:response.data];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUpdateOrderCoupon {
    WGUpdateOrderCouponRequest *request = [[WGUpdateOrderCouponRequest alloc] init];
    request.settlementId = self.settlementId;
    request.couponId = _commitOrderDetail.coupon.id;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGUpdateOrderCouponResponse class] success:^(JHResponse *response) {
        [weakSelf handleUpdateOrderCouponResponse:(WGUpdateOrderCouponResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleUpdateOrderCouponResponse:(WGUpdateOrderCouponResponse *)response {
    if (response.success) {
        _commitOrderDetail.consumePrice = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
