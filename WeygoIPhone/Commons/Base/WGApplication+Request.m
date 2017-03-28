//
//  WGApplication+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Request.h"
#import "JHNetworkManager.h"
#import "WGClassifyRequest.h"

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

//- (void)loadClassifyOnCompletion:(void (^)(WGSessionResponse *))completion {
//    if (_loadingSessionResponse) {
//        return;
//    }
//    _loadingSessionResponse = YES;
//    __weak id weakSelf = self;
//    WGClassifyRequest *request = [[WGClassifyRequest alloc] init];
//    [[JHNetworkManager sharedManager] get:request forResponseClass:[WGSessionResponse class] success:^(JHResponse *response) {
//        _loadingSessionResponse = NO;
//        [weakSelf handleClassifyResponse:(WGSessionResponse *)response];
//        if (completion) {
//            completion((WGSessionResponse *)response);
//        }
//    } failure:^(NSError *error) {
//        _loadingSessionResponse = NO;
//        if (completion) {
//            completion(nil);
//        }
//    }];
//}
//
//- (void)handleClassifyResponse:(WGSessionResponse *)response {
//    if ([response success]) {
//        _sessionResponse = response;
//    }
//}

- (void)loadImageVerificationCodeOnCompletion:(void (^)(WGImageVerificationCodeResponse *))completion {
    
}

- (void)loadAddGoodToCart:(long long)goodId
                    count:(NSInteger)count
             onCompletion:(void (^)(WGAddGoodToCartResponse *))completion {
    WGAddGoodToCartRequest *request = [[WGAddGoodToCartRequest alloc] init];
    [[JHNetworkManager sharedManager] post:request forResponseClass:[WGSessionResponse class] success:^(JHResponse *response) {
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
