//
//  WGApplication.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "JHNetworkManager.h"
#import "WGClassifyRequest.h"

@interface WGApplication ()
{
    BOOL _loadingSessionResponse;
}
@end

@implementation WGApplication

static WGApplication* _sharedInstance = nil;

+ (WGApplication *)sharedApplication {
    @synchronized([WGApplication class]) {
        if(!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
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

@end
