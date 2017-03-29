//
//  WGFootPrintViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGFootPrintViewController.h"
#import "WGFootPrintListRequest.h"
#import "WGFootPrintListResponse.h"
#import "WGDeleteFootPrintRequest.h"
#import "WGDeleteFootPrintResponse.h"
#import "WGHomeFloorContentGoodItem.h"

@interface WGFootPrintViewController ()

@end

@implementation WGFootPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"FootPrint");
}

- (void)handleDeleteIndexPath:(NSIndexPath *)indexPath {
    if (_dataMArray.count > indexPath.row) {
        WGHomeFloorContentGoodItem *item = _dataMArray[indexPath.row];
        WGDeleteFootPrintRequest *request = [[WGDeleteFootPrintRequest alloc] init];
        request.goodId = item.id;
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGDeleteFootPrintResponse class] success:^(JHResponse *response) {
            [weakSelf handleDeleteFootPrintResponse:(WGDeleteFootPrintResponse *)response goodId:item.id];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
}

- (void)handleDeleteFootPrintResponse:(WGDeleteFootPrintResponse *)response goodId:(long long)goodId {
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
    WGFootPrintListRequest *request = [[WGFootPrintListRequest alloc] init];
    request.pageId = (refresh) ? 0 : _dataMArray.count;
    request.pageSize = 15;
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGFootPrintListResponse class] success:^(JHResponse *response) {
        [weakSelf handleFootPrintListResponse:(WGFootPrintListResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleFootPrintListResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleFootPrintListResponse:(WGFootPrintListResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
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
