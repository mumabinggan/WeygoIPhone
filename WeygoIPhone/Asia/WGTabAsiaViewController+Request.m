//
//  WGTabAsiaViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabAsiaViewController+Request.h"
#import "WGHomeTabContentRequest.h"
#import "WGHomeTabContentResponse.h"

@implementation WGTabAsiaViewController (Request)

- (void)loadAsiaClassify:(WGCacheType)cacheType {
    WeakSelf;
    [self loadAsiaClassifyOnCompletion:^(WGHomeTabContentResponse *response) {
        [weakSelf handleHomeContent:response];
    } cacheType:cacheType];
}

- (void)loadAsiaClassifyOnCompletion:(void (^)(WGHomeTabContentResponse *))completion cacheType:(WGCacheType)cacheType {
    if (cacheType != WGCacheTypeNetwork) {
        WGHomeTabContentResponse *cacheResponse = [[WGHomeTabContentResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsAsiaCache]];
        if (cacheResponse) {
            if (completion) {
                completion(cacheResponse);
                if (cacheType == WGCacheTypeCachePrior) {
                    return;
                }
            }
        }
    }
    WGHomeTabContentRequest *request = [[WGHomeTabContentRequest alloc] init];
    request.menuId = 193;
    if (_data) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGHomeTabContentResponse *)response);
        }
        //[weakSelf handleHomeContent:(WGHomeTabContentResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHomeContent:(WGHomeTabContentResponse *)response {
    if (_contentVC) {
        [self stopRefreshing:_contentVC.tableView refresh:YES pulling:YES];
    }
    if (response.success) {
        _data = response.data;
        WGHomeTabContentResponse *cacheResponse = response;
        [[JHLocalSettings sharedSettings] setSettings:cacheResponse.toJSONString forKey:kLocalSettingsAsiaCache];
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
