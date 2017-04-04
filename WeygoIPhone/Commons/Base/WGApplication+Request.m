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
    request.goodIds = @(goodId).stringValue;
    request.counts = @(count).stringValue;
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

@end
