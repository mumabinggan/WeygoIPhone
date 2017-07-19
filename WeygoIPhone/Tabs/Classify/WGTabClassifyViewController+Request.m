//
//  WGTabClassifyViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabClassifyViewController+Request.h"
#import "WGClassifyRequest.h"
#import "WGClassifyResponse.h"
#import "WGClassifyItem.h"

@implementation WGTabClassifyViewController (Request)

- (void)loadClassify:(WGCacheType)cacheType {
    WeakSelf;
    [self loadClassifyOnCompletion:^(WGClassifyResponse *response) {
        [weakSelf handleClassifyResponse:response];
    } cacheType:WGCacheTypeCacheBoth];
}

- (void)loadClassifyOnCompletion:(void (^)(WGClassifyResponse *))completion cacheType:(WGCacheType)cacheType {
    if (cacheType != WGCacheTypeNetwork) {
        WGClassifyResponse *cacheResponse = [[WGClassifyResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsClassifyCache]];
        if (cacheResponse) {
            if (completion) {
                completion(cacheResponse);
            }
        }
        if (cacheType == WGCacheTypeCachePrior && cacheResponse) {
            return;
        }
    }
    
    WGClassifyRequest *request = [[WGClassifyRequest alloc] init];
    request.is_hot = 0;
    if (_data) {
        request.showsLoadingView = NO;
    }
    WeakSelf;
    [self post:request forResponseClass:[WGClassifyResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGClassifyResponse *)response);
        }
        //[weakSelf handleClassifyResponse:(WGClassifyResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClassifyResponse:(WGClassifyResponse *)response {
    if (response.success) {
        _data = response.data;
        [[JHLocalSettings sharedSettings] setSettings:response.toJSONString forKey:kLocalSettingsClassifyCache];
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
