//
//  WGMessageCenterViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageCenterViewController+Request.h"
#import "WGMessageRequest.h"
#import "WGMessageResponse.h"
#import "WGMessageReadRequest.h"
#import "WGMessageReadResponse.h"
#import "WGDeleteMessageRequest.h"
#import "WGDeleteMessageResponse.h"

@implementation WGMessageCenterViewController (Request)

- (void)loadMessageList:(BOOL)refresh pulling:(BOOL)pulling {
    WGMessageRequest *request = [[WGMessageRequest alloc] init];
    request.tabType = _currentTabType;
    request.pageId = (refresh) ? 0 : _currentArray.count;
    request.pageSize = 10;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    WGMessageTabType type = _currentTabType;
    [self post:request forResponseClass:[WGMessageResponse class] success:^(JHResponse *response) {
        [weakSelf handleMessageListResponse:(WGMessageResponse *)response tabType:type refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleMessageListFailResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleMessageListResponse:(WGMessageResponse *)response tabType:(WGMessageTabType)tabType refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (response.success) {
        if (tabType == WGMessageTabTypeAll) {
            if (!_allMArray) {
                _allMArray = [[NSMutableArray alloc] init];
            }
            if (refresh) {
                [_allMArray removeAllObjects];
            }
            [_allMArray addObjectsFromArray:response.data];
        }
        else if (tabType == WGMessageTabTypeNew) {
            if (!_newMArray) {
                _newMArray = [[NSMutableArray alloc] init];
            }
            if (refresh) {
                [_newMArray removeAllObjects];
            }
            [_newMArray addObjectsFromArray:response.data];
        }
        else if (tabType == WGMessageTabTypeDeliver) {
            if (!_deliverMArray) {
                _deliverMArray = [[NSMutableArray alloc] init];
            }
            if (refresh) {
                [_deliverMArray removeAllObjects];
            }
            [_deliverMArray addObjectsFromArray:response.data];
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)handleMessageListFailResponse:(WGMessageResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    [self showWarningMessage:kStr(@"Request Failed")];
}

- (void)loadMessageDetail:(long long)messageId {
    WGMessageReadRequest *request = [[WGMessageReadRequest alloc] init];
    request.messageId = messageId;
    request.showsLoadingView = NO;
    WGMessageTabType tabType = _currentTabType;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGMessageReadResponse class] success:^(JHResponse *response) {
        [weakSelf handleMessageDetailResponse:(WGMessageReadResponse *)response tabType:tabType];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleMessageDetailResponse:(WGMessageReadResponse *)response tabType:(WGMessageTabType)tabType {
    if (response.success) {
        NSArray *array = nil;
        if (tabType == WGMessageTabTypeAll) {
            array = _allMArray;
        }
        else if (tabType == WGMessageTabTypeNew) {
            array = _newMArray;
        }
        else if (tabType == WGMessageTabTypeDeliver) {
            array = _deliverMArray;
        }
        for (WGMessageItem *item in array) {
            if (item.id == response.data.id) {
                item.isRead = YES;
                break;
            }
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadDeleteMessage:(long long)messageId {
    WGDeleteMessageRequest *request = [[WGDeleteMessageRequest alloc] init];
    request.messageId = messageId;
    request.showsLoadingView = NO;
    WGMessageTabType tabType = _currentTabType;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGDeleteMessageResponse class] success:^(JHResponse *response) {
        [weakSelf handleDeleteMessageResponse:(WGDeleteMessageResponse *)response tabType:tabType];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleDeleteMessageResponse:(WGDeleteMessageResponse *)response tabType:(WGMessageTabType)tabType {
    if (response.success) {
        NSMutableArray *array = nil;
        if (tabType == WGMessageTabTypeAll) {
            array = _allMArray;
        }
        else if (tabType == WGMessageTabTypeNew) {
            array = _newMArray;
        }
        else if (tabType == WGMessageTabTypeDeliver) {
            array = _deliverMArray;
        }
        for (WGMessageItem *item in array) {
            if (item.id == response.data.id) {
                [array removeObject:item];
                break;
            }
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
