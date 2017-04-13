//
//  WGCommonClassifyDetailViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailContentViewController+Request.h"
#import "WGClassifyDetailRequest.h"
#import "WGClassifyDetailResponse.h"
#import "WGClassifyKeyword.h"
#import "WGClassifyItem.h"

@implementation WGClassifyDetailContentViewController (Request)

- (void)loadClassifyDetailFilter:(BOOL)refresh pulling:(BOOL)pulling {
    WGClassifyDetailRequest *request = [[WGClassifyDetailRequest alloc] init];
    request.classifyId = self.classifyId;
    request.order = _sortType;
    request.pageId = refresh ? 0 :  (int)_data.goodArray.count;
    NSMutableArray *keywords = [NSMutableArray array];
    for (WGClassifyKeyword *item in _filter.keyWordArray) {
        if (item.isSelected) {
            [keywords addObject:@(item.id).stringValue];
        }
    }
    request.brandIds = [keywords join:@","];
    NSMutableArray *subClassifys = [NSMutableArray array];
    for (WGClassifyItem *item in _filter.classifyArray) {
        if (item.isSelected) {
            [subClassifys addObject:@(item.id).stringValue];
        }
    }
    request.subClassifyIds = [subClassifys join:@","];
    request.pageSize = 15;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGClassifyDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    if (response.success) {
        if (refresh) {
            _data = response.data;
        }
        else {
            NSMutableArray *goods = [NSMutableArray arrayWithArray:_data.goodArray];
            [goods addObjectsFromArray:response.data.goodArray];
            _data = response.data;
            _data.goodArray = goods;
        }
        if (self.onResponse) {
            self.onResponse(_data);
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
