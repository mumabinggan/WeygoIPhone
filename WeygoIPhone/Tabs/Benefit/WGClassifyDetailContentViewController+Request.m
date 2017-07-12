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
#import "WGTitleItem.h"
#import "WGHomeTabTitleResponse.h"

@implementation WGClassifyDetailContentViewController (Request)

- (void)loadNeedCheckData:(WGCacheType)cacheType {
    [self loadData:YES pulling:NO cacheType:cacheType];
}

- (void)loadData:(BOOL)refresh pulling:(BOOL)pulling cacheType:(WGCacheType)cacheType {
    WeakSelf;
    [self loadClassifyDetailNormal:refresh pulling:pulling cacheType:cacheType onCompletion:^(WGClassifyDetailResponse *response, BOOL refresh, BOOL pulling) {
        [weakSelf handleClassifyDetailResponse:response refresh:refresh pulling:pulling cacheType:WGCacheTypeCacheBoth];
        //[weakSelf handleClassifyDetailResponse:response refresh:refresh pulling:pulling];
    }];
}

- (void)loadClassifyDetailNormal:(BOOL)refresh pulling:(BOOL)pulling cacheType:(WGCacheType)cacheType onCompletion:(void (^)(WGClassifyDetailResponse *response, BOOL refresh, BOOL pulling))completion {
    if (cacheType != WGCacheTypeNetwork) {
        if (completion) {
            WGTitleItem *item = [self dataWithMenuId:self.classifyId];
            NSString *key = kLocalSettingsClassifyContentCache(self.classifyId);
            WGClassifyDetailResponse *cacheResponse = [[WGClassifyDetailResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:key]];
            if (item && cacheResponse) {
                completion(cacheResponse, refresh, pulling);
                if (cacheType == WGCacheTypeCachePrior) {
                    return;
                }
            }
        }
    }
    
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
    if (pulling && _data) {
        request.showsLoadingView = NO;
    }
    [self post:request forResponseClass:[WGClassifyDetailResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGClassifyDetailResponse *)response, refresh, pulling);
        }
        //[weakSelf handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil, refresh, pulling);
        }
    }];
}

- (void)handleClassifyDetailResponse:(WGClassifyDetailResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling cacheType:(WGCacheType)cacheType {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        NSInteger scrollRow = _data.goodArray.count / (_isGrid ? 2 : 1);
        if (refresh) {
            _data = response.data;
            WGClassifyDetailResponse *cacheResponse = response;
            NSString *key = kLocalSettingsClassifyContentCache(self.classifyId);
            [[JHLocalSettings sharedSettings] setSettings:cacheResponse.toJSONString forKey:key];
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

- (long)menuIdWithIndex:(NSInteger)index {
    WGTitleItem *item = [self dataWithIndex:index];
    if (item) {
        return item.id;
    }
    return -1;
}

- (WGTitleItem *)dataWithMenuId:(long)menuId {
    WGHomeTabTitleResponse *response = [[WGHomeTabTitleResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsBenefitTitlesCache]];
    NSArray *array = response.data;
    for (int num = 0; num < array.count; ++num) {
        WGTitleItem *item = array[num];
        if (item.id == menuId) {
            return item;
        }
    }
    return nil;
}

- (NSInteger)indexWithMenuId:(long)menuId {
    WGHomeTabTitleResponse *response = [[WGHomeTabTitleResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsBenefitTitlesCache]];
    NSArray *array = response.data;
    for (int num = 0; num < array.count; ++num) {
        WGTitleItem *item = array[num];
        if (item.id == menuId) {
            return num;
        }
    }
    return 0;
}

- (WGTitleItem *)dataWithIndex:(NSInteger)index {
    WGHomeTabTitleResponse *response = [[WGHomeTabTitleResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsBenefitTitlesCache]];
    if (response.data.count <= index) {
        index = 0;
    }
    WGTitleItem *item = response.data[index];
    return item;
}

@end
