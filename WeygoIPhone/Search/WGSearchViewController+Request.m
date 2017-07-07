//
//  WGSearchViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSearchViewController+Request.h"
#import "WGHotSearchRequest.h"
#import "WGHotSearchResponse.h"
#import "WGKeywordSearchGoodListRequest.h"
#import "WGKeywordSearchGoodListResponse.h"
#import "WGSearchRequest.h"
#import "WGSearchResponse.h"

@implementation WGSearchViewController (Request)

- (void)loadSearch {
    WGSearchRequest *request = [[WGSearchRequest alloc] init];
    request.name = _textFiled.text;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSearchResponse class] success:^(JHResponse *response) {
        [weakSelf handleSearchResponse:(WGSearchResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleSearchResponse:(WGSearchResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadSearch:(BOOL)refresh pulling:(BOOL)pulling {
    WGSearchRequest *request = [[WGSearchRequest alloc] init];
    request.name = _currentSearchString;
    request.pageId = refresh ? 0 :  (int)_data.goods.count;
    request.pageSize = 10;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSearchResponse class] success:^(JHResponse *response) {
        [weakSelf handleSearchResponse:(WGSearchResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleSearchResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleSearchResponse:(WGSearchResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        if (refresh) {
            _data = response.data;
        }
        else {
            NSMutableArray *goods = [NSMutableArray arrayWithArray:_data.goods];
            [goods addObjectsFromArray:response.data.goods];
            _data = response.data;
            _data.goods = goods;
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
