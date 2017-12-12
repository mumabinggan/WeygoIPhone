//
//  WGCommonViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController+Request.h"
#import "WGHomeTabTitleRequest.h"
#import "WGHomeTabTitleResponse.h"
#import "WGHomeTabContentRequest.h"
#import "WGHomeTabContentResponse.h"
#import "WGTitleItem.h"
#import "WGCommonViewController+Contents.h"
#import "WGClassifyRequest.h"
#import "WGClassifyResponse.h"

//can delete
#import "WGCarouselFigureItem.h"
#import "WGTopicItem.h"
#import "WGNewsItem.h"
#import "WGHomeFloorItem.h"
#import "WGHomeFloorContentItem.h"
#import "WGNews.h"
#import "WGCommonViewController+Scroll.h"

#import "WGCommonViewController+Segment.h"

@implementation WGCommonViewController (Request)

- (void)loadData {
    WeakSelf;
    [self loadHomeTabTitlesOnCompletion:^(WGHomeTabTitleResponse *response) {
        [weakSelf handleHomeTabTitles:response];
    }];
}

- (void)loadHomeTabTitlesOnCompletion:(void (^)(WGHomeTabTitleResponse *))completion {
    if (!_hadReadTitlesCache) {
        _dataResponse = [[WGHomeTabTitleResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsHomeCache]];
        if (_dataResponse) {
            if (completion) {
                completion(_dataResponse);
            }
        }
        _hadReadTitlesCache = YES;
    }
    
    WGHomeTabTitleRequest *request = [[WGHomeTabTitleRequest alloc] init];
    request.showsLoadingView = _dataResponse ? NO : YES;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHomeTabTitleResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGHomeTabTitleResponse *)response);
        }
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHomeTabTitles:(WGHomeTabTitleResponse *)response {
    if (response.success) {
        if (_dataResponse) {
            [_dataResponse setTitles:response];
        }
        else {
            _dataResponse = response;
        }
        [[JHLocalSettings sharedSettings] setSettings:_dataResponse.toJSONString forKey:kLocalSettingsHomeCache];
        [self addTitleSegmentView];
        [self setContentsScrollView];
        NSInteger index = _titleSegmentView.selectedIndex;
        long menuId = [self menuIdWithIndex:index];
        if (menuId >= 0) {
            [self loadContentWithMenuId:menuId cacheType:WGCacheTypeCacheBoth];
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadContentWithMenuId:(NSInteger)menuId cacheType:(WGCacheType)cacheType {
    WeakSelf;
    [self loadHomeContentWithMenuId:menuId cacheType:cacheType onCompletion:^(WGHomeTabContentResponse *response, long menuId) {
        [weakSelf handleHomeContent:response menuId:menuId];
    }];
}

//- (void)loadContentWithMenuId:(NSInteger)menuId isFirst:(BOOL)isFirst useCache:(BOOL)useCache {
//    WeakSelf;
//    [self loadHomeContentWithMenuId:menuId isFirst:isFirst onCompletion:^(WGHomeTabContentResponse *response, long menuId, BOOL isFirst) {
//        [weakSelf handleHomeContent:response menuId:menuId isFirst:isFirst];
//    }];
//}

- (void)loadHomeContentWithMenuId:(long)menuId cacheType:(WGCacheType)cacheType onCompletion:(void (^)(WGHomeTabContentResponse *response, long menuId))completion {
    if (cacheType != WGCacheTypeNetwork) {
        WGTitleItem *item = [self dataWithMenuId:menuId];
        NSNumber *readBool = [_hadReadContentCacheDictionary objectForKey:@(menuId)];
        if (item) {
            if (readBool.boolValue) {
                if (cacheType == WGCacheTypeCachePrior) {
                    if (item.data) {
                        WGHomeTabContentResponse *response = [[WGHomeTabContentResponse alloc] init];
                        response.data = item.data;
                        response.code = 1;
                        completion(response, menuId);
                        return;
                    }
                }
                else {
                    if (item.data) {
                        WGHomeTabContentResponse *response = [[WGHomeTabContentResponse alloc] init];
                        response.data = item.data;
                        response.code = 1;
                        completion(response, menuId);
                    }
                }
            }
            else {
                if (item.data) {
                    if (completion) {
                        WGHomeTabContentResponse *response = [[WGHomeTabContentResponse alloc] init];
                        response.data = item.data;
                        response.code = 1;
                        completion(response, menuId);
                    }
                }
                [_hadReadContentCacheDictionary setObject:@(YES) forKey:@(menuId)];
            }
        }
    }
    WGHomeTabContentRequest *request = [[WGHomeTabContentRequest alloc] init];
    request.menuId = menuId;
    JHObject *object = [self dataWithMenuId:menuId];
    if (object) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGHomeTabContentResponse *)response, menuId);
        }
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHomeContent:(WGHomeTabContentResponse *)response menuId:(long)menuId {
    NSInteger index = [self indexWithMenuId:menuId];
    WGHomeTabContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (contentVC) {
        [self stopRefreshing:contentVC.tableView refresh:YES pulling:YES];
    }
    if (response.success) {
        if (_dataResponse.data.count > index) {
            WGTitleItem *item = _dataResponse.data[index];
            item.data = response.data;
            [[JHLocalSettings sharedSettings] setSettings:_dataResponse.toJSONString forKey:kLocalSettingsHomeCache];
        }
        [self refreshContent:index];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
