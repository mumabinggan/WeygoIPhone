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

- (void)loadNeedCheckData {
    if (!_data) {
        [self loadData:YES pulling:NO];
    }
}

- (void)loadData:(BOOL)refresh pulling:(BOOL)pulling {
    if (self.type == WGClassifyDetailTypeNormal) {
        [self loadClassifyDetailNormal:refresh pulling:pulling];
    }
    else if (self.type == WGClassifyDetailTypeBenefit) {
        [self loadClassifyDetailBenefit:refresh pulling:pulling];
    }
    else if (self.type == WGClassifyDetailTypeCountry) {
        [self loadClassifyDetailCountry:refresh pulling:pulling];
    }
}

- (void)loadClassifyDetailNormal:(BOOL)refresh pulling:(BOOL)pulling {
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
    request.pageSize = 10;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGClassifyDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleClassifyDetailResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        NSInteger scrollRow = _data.goodArray.count / (_isGrid ? 2 : 1);
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
        if (_data.recommendedArray && _data.recommendedArray.count > 0) {
            _isGrid = YES;
        }
        [self refreshUI];
        if (!refresh && scrollRow < _data.goodArray.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:scrollRow inSection:1];
            [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadClassifyDetailBenefit:(BOOL)refresh pulling:(BOOL)pulling {

}

- (void)loadClassifyDetailCountry:(BOOL)refresh pulling:(BOOL)pulling {
    
}

@end
