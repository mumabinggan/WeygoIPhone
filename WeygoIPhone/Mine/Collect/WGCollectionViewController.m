//
//  WGCollectionViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCollectionViewController.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGCancelCollectGoodRequest.h"
#import "WGCancelCollectGoodResponse.h"
#import "WGCollectionListRequest.h"
#import "WGCollectionListResponse.h"

@implementation WGCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Collection");
}

- (void)handleDeleteIndexPath:(NSIndexPath *)indexPath {
    if (_dataMArray.count > indexPath.row) {
        WGHomeFloorContentGoodItem *item = _dataMArray[indexPath.row];
        WGCancelCollectGoodRequest *request = [[WGCancelCollectGoodRequest alloc] init];
        request.goodId = item.id;
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGCancelCollectGoodResponse class] success:^(JHResponse *response) {
            [weakSelf handleCancelCollectGoodResponse:(WGCancelCollectGoodResponse *)response goodId:item.id];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
}

- (void)handleCancelCollectGoodResponse:(WGCancelCollectGoodResponse *)response goodId:(long long)goodId {
    if (response.success) {
        for (WGHomeFloorContentGoodItem *item in _dataMArray) {
            if (item.id == goodId) {
                [_dataMArray removeObject:item];
                [self refreshUI];
                break;
            }
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadListResponse:(BOOL)refresh pulling:(BOOL)pulling {
    WGCollectionListRequest *request = [[WGCollectionListRequest alloc] init];
    request.pageId = (refresh) ? 0 : _dataMArray.count;
    request.pageSize = 15;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCollectionListResponse class] success:^(JHResponse *response) {
        [weakSelf handleCollectionListResponse:(WGCollectionListResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleCollectionListResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleCollectionListResponse:(WGCollectionListResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        if (refresh) {
            [_dataMArray removeAllObjects];
        }
        [_dataMArray addObjectsFromArray:response.data];
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
