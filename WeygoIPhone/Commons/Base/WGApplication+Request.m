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
    [[JHNetworkManager sharedManager] postSoap:request forResponseClass:[WGBaseServiceResponse class] success:^(JHResponse *response) {
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
        _baseServiceResponse = response;
    }
}

- (void)loadSessionOnCompletion:(void (^)(WGSessionResponse *))completion {
    if (_loadingSessionResponse) {
        return;
    }
    _loadingSessionResponse = YES;
    __weak id weakSelf = self;
    WGSessionRequest *request = [[WGSessionRequest alloc] init];
    [[JHNetworkManager sharedManager] postSoap:request forResponseClass:[WGSessionResponse class] success:^(JHResponse *response) {
        _loadingSessionResponse = NO;
        [weakSelf handleSessionResponse:(WGSessionResponse *)response];
        if (completion) {
            completion((WGSessionResponse *)response);
        }
    } failure:^(NSError *error) {
        _loadingSessionResponse = NO;
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleSessionResponse:(WGSessionResponse *)response {
    if ([response success]) {
        _sessionResponse = response;
    }
}

- (void)loadClassifyOnCompletion:(void (^)(WGSessionResponse *))completion {
    if (_loadingSessionResponse) {
        return;
    }
    _loadingSessionResponse = YES;
    __weak id weakSelf = self;
    WGClassifyRequest *request = [[WGClassifyRequest alloc] init];
    [[JHNetworkManager sharedManager] postSoap:request forResponseClass:[WGSessionResponse class] success:^(JHResponse *response) {
        _loadingSessionResponse = NO;
        [weakSelf handleClassifyResponse:(WGSessionResponse *)response];
        if (completion) {
            completion((WGSessionResponse *)response);
        }
    } failure:^(NSError *error) {
        _loadingSessionResponse = NO;
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)handleClassifyResponse:(WGSessionResponse *)response {
    if ([response success]) {
        _sessionResponse = response;
    }
}

- (void)loadImageVerificationCodeOnCompletion:(void (^)(WGImageVerificationCodeResponse *))completion {
    
}

@end
