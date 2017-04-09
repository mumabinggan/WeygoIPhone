//
//  WGApplication+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Request.h"
#import "JHNetworkManager.h"
#import "WGHomeSliderRequest.h"
#import "WGUserInfoRequest.h"
#import "WGUserInfoResponse.h"

@implementation WGApplication (Request)

- (void)loadBaseServiceOnCompletion:(void (^)(WGBaseServiceResponse *))completion {
    __weak id weakSelf = self;
    WGBaseServiceRequest *request = [[WGBaseServiceRequest alloc] init];
    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGBaseServiceResponse class] success:^(JHResponse *response) {
        [weakSelf handleBaseServiceResponse:(WGBaseServiceResponse *)response];
        if (completion) {
            completion((WGBaseServiceResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleBaseServiceResponse:(WGBaseServiceResponse *)response {
    if ([response success]) {
        _baseServiceInfo = response.data;
    }
}

- (void)loadSliderResponseOnCompletion:(void (^)(WGHomeSliderResponse *))completion {
    if (_sliderResponse) {
        if (completion) {
            completion(_sliderResponse);
        }
    }
    if (_loadingSliderResponse) {
        return;
    }
    _loadingSliderResponse = YES;
    __weak id weakSelf = self;
    WGHomeSliderRequest *request = [[WGHomeSliderRequest alloc] init];
    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGHomeSliderResponse class] success:^(JHResponse *response) {
        _loadingSliderResponse = NO;
        [weakSelf handleSliderResponse:(WGHomeSliderResponse *)response];
        if (completion) {
            completion((WGHomeSliderResponse *)response);
        }
    } failure:^(NSError *error) {
        _loadingSliderResponse = NO;
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleSliderResponse:(WGHomeSliderResponse *)response {
    if ([response success]) {
        _sliderResponse = response;
    }
}

- (void)loadImageVerificationCodeOnCompletion:(void (^)(WGImageVerificationCodeResponse *))completion {
    
}

- (void)loadAddGoodToCart:(long long)goodId
                    count:(NSInteger)count
             onCompletion:(void (^)(WGAddGoodToCartResponse *))completion {
    WGAddGoodToCartRequest *request = [[WGAddGoodToCartRequest alloc] init];
    request.goodId = goodId;
    request.count = count;
    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGAddGoodToCartResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGAddGoodToCartResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)loadUserInfoOnCompletion:(void (^)(WGUserInfoResponse *))completion {
    WGUserInfoRequest *request = [[WGUserInfoRequest alloc] init];
    WeakSelf;
    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGUserInfoResponse class] success:^(JHResponse *response) {
        [weakSelf handleUserInfoResponse:(WGUserInfoResponse *)response];
        if (completion) {
            completion((WGUserInfoResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleUserInfoResponse:(WGUserInfoResponse *)response {
    if (response.success) {
        [self setUser:response.data];
    }
}

- (void)loadVerificationCodeUserName:(NSString *)username countryCode:(NSString *)countryCode onCompletion:(void (^)(WGGetVerifyCodeResponse *))completion {
    WGGetVerifyCodeRequest *request = [[WGGetVerifyCodeRequest alloc] init];
    request.username = username;
    request.countryCode = countryCode;
    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGGetVerifyCodeResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGGetVerifyCodeResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)loadReceiptCountryListOnCompletion:(void (^)(WGReceiptCountryListResponse *))completion {
    if (_loadingReceiptCountryListResponse) {
        return;
    }
    if (_receiptCountryResponse) {
        if (completion) {
            completion(_receiptCountryResponse);
        }
        return;
    }
    WeakSelf;
    _loadingReceiptCountryListResponse = YES;
    WGReceiptCountryListRequest *request = [[WGReceiptCountryListRequest alloc] init];
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGReceiptCountryListResponse class] success:^(JHResponse *response) {
        _loadingReceiptCountryListResponse = NO;
        [weakSelf handleReceiptCountryListResponse:(WGReceiptCountryListResponse *)response];
        if (completion) {
            completion((WGReceiptCountryListResponse *)response);
        }
    } failure:^(NSError *error) {
        _loadingReceiptCountryListResponse = NO;
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleReceiptCountryListResponse:(WGReceiptCountryListResponse *)response {
    if (response.success) {
        _receiptCountryResponse = response;
    }
}

@end
