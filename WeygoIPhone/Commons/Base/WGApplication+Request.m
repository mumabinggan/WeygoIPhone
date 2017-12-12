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
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGBaseServiceResponse class] success:^(JHResponse *response) {
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
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGAddGoodToCartResponse class] success:^(JHResponse *response) {
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
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGUserInfoResponse class] success:^(JHResponse *response) {
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

- (void)loadLogoutOnCompletion:(void (^)(WGLogoutResponse *))completion {
    WeakSelf;
    WGLogoutRequest *request = [[WGLogoutRequest alloc] init];
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGLogoutResponse class] success:^(JHResponse *response) {
        [weakSelf handleLogoutResponse:(WGLogoutResponse *)response];
        if (completion) {
            completion((WGLogoutResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleLogoutResponse:(WGLogoutResponse *)response {
    if (response.success) {
        [self reset];
    }
}

- (void)loadShopCartCountOnCompletion:(void (^)(WGShopCartCountResponse *))completion {
    WeakSelf;
    WGShopCartCountRequest *request = [[WGShopCartCountRequest alloc] init];
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGShopCartCountResponse class] success:^(JHResponse *response) {
        [weakSelf handleShopCartCountResponse:(WGShopCartCountResponse *)response];
        if (completion) {
            completion((WGShopCartCountResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleShopCartCountResponse:(WGShopCartCountResponse *)response {
    [self handleShopCartGoodCount:response.data.goodCount];
}

- (void)loadRebuyOrder:(long long)orderId onCompletion:(void (^)(WGRebuyOrderResponse *))completion {
    WGRebuyOrderRequest *request = [[WGRebuyOrderRequest alloc] init];
    request.orderId = orderId;
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGRebuyOrderResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGRebuyOrderResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)loadSetPostCode:(NSString *)cap onCompletion:(void (^)(WGSetPostCodeResponse *))completion {
    WGSetPostCodeRequest *request = [[WGSetPostCodeRequest alloc] init];
    request.cap = cap;
    WeakSelf;
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGSetPostCodeResponse class] success:^(JHResponse *response) {
        [weakSelf handleSetPostCodeResponse:(WGSetPostCodeResponse *)response cap:cap];
        if (completion) {
            completion((WGSetPostCodeResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleSetPostCodeResponse:(WGSetPostCodeResponse *)response cap:(NSString *)cap {
    if (response.success) {
        [WGApplication sharedApplication].currentPostCode = cap;
    }
}

- (void)loadCheckBind:(NSString *)uniqueId type:(WGThirdPartyLoginType)type onCompletion:(void (^)(WGCheckBindResponse *))completion {
    WGCheckBindRequest *request = [[WGCheckBindRequest alloc] init];
    request.uniqueId = uniqueId;
    request.type = type;
    WeakSelf;
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGCheckBindResponse class] success:^(JHResponse *response) {
        [weakSelf handleCheckBindResponse:(WGCheckBindResponse *)response];
        if (completion) {
            completion((WGCheckBindResponse *)response);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleCheckBindResponse:(WGCheckBindResponse *)response {
    if (response.bind) {
        [[WGApplication sharedApplication] reset];
        [WGApplication sharedApplication].user = response.data;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshRequired
                                                            object:@(WGRefreshNotificationTypeLogin)];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogIn object:nil];
        [self switchTab:WGTabIndexMine];
    }
}

@end
