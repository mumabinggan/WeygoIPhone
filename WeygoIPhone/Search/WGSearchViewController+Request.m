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

@end
