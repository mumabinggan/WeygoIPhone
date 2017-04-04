//
//  WGShopCartViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartViewController+Request.h"
#import "WGShopCartRequest.h"
#import "WGShopCartResponse.h"
#import "WGDeleteGoodFromShopCartRequest.h"
#import "WGDeleteGoodFromShopCartResponse.h"
#import "WGShopCart.h"
#import "WGShopCartGoodItem.h"
#import "WGUpdateProductsRequest.h"
#import "WGUpdateProductsResponse.h"
#import "WGDealFailureProductsRequest.h"
#import "WGDealFailureProductsResponse.h"
#import "WGCheckFailureProductsRequest.h"
#import "WGCheckFailureProductsResponse.h"
#import "WGDealShopCartGiftResponse.h"
#import "WGDealShopCartGiftRequest.h"
#import "WGShopCartGiftRequest.h"
#import "WGShopCartGiftResponse.h"
#import "WGCommitOrderViewController.h"

@implementation WGShopCartViewController (Request)

- (void)loadDeleteIndexPath:(NSIndexPath *)indexPath {
    if (_data && _data.goods && _data.goods.count > indexPath.row) {
        WGShopCartGoodItem *item = _data.goods[indexPath.row];
        WGDeleteGoodFromShopCartRequest *request = [[WGDeleteGoodFromShopCartRequest alloc] init];
        request.id = item.shopCartId;
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGDeleteGoodFromShopCartResponse class] success:^(JHResponse *response) {
            [weakSelf handleDeleteGoodResponse:(WGDeleteGoodFromShopCartResponse *)response goodId:item.id];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
}

- (void)handleDeleteGoodResponse:(WGDeleteGoodFromShopCartResponse *)response goodId:(long long)goodId {
    if (response.success) {
        [self loadShopCartList:YES pulling:NO];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUpdateGood:(WGShopCartGoodItem *)item {
    WGUpdateProductsRequest *request = [[WGUpdateProductsRequest alloc] init];
    request.id = item.shopCartId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGUpdateProductsResponse class] success:^(JHResponse *response) {
        [weakSelf handleUpdateGoodResponse:(WGUpdateProductsResponse *)response goodId:item.id];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleUpdateGoodResponse:(WGUpdateProductsResponse *)response goodId:(long long)goodId {
    if (response.success) {
        [self loadShopCartList:YES pulling:NO];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadCheckFailureGood {
    WGCheckFailureProductsRequest *request = [[WGCheckFailureProductsRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCheckFailureProductsResponse class] success:^(JHResponse *response) {
        [weakSelf handleCheckFailureGoodResponse:(WGCheckFailureProductsResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleCheckFailureGoodResponse:(WGCheckFailureProductsResponse *)response {
    if (response.code == 100) {
        //有失效产品
    }
    else if (response.code == 101) {
        //无失效产品
        [self loadGiftGood];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadDealFailureGood:(int)type {
    WGDealFailureProductsRequest *request = [[WGDealFailureProductsRequest alloc] init];
    request.type = type;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGDealFailureProductsResponse class] success:^(JHResponse *response) {
        [weakSelf handleDealFailureGoodResponse:(WGDealFailureProductsResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleDealFailureGoodResponse:(WGDealFailureProductsResponse *)response {
    if (response.success) {
        [self loadGiftGood];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadGiftGood {
    WGShopCartGiftRequest *request = [[WGShopCartGiftRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGShopCartGiftResponse class] success:^(JHResponse *response) {
        [weakSelf handleGiftGoodResponse:(WGShopCartGiftResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleGiftGoodResponse:(WGShopCartGiftResponse *)response {
    if (response.success) {
        if (response.data && response.data.count > 0) {
            //弹出列表
            
        }
        else {
            [self intoCommitOrderViewController];
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadDealGiftGood:(int)type {
    WGDealShopCartGiftRequest *request = [[WGDealShopCartGiftRequest alloc] init];
    request.type = type;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGDealShopCartGiftResponse class] success:^(JHResponse *response) {
        [weakSelf handleDealGiftGoodResponse:(WGDealShopCartGiftResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleDealGiftGoodResponse:(WGDealShopCartGiftResponse *)response {
    if (response.success) {
        [self intoCommitOrderViewController];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadShopCartList:(BOOL)refresh pulling:(BOOL)pulling {
    WGShopCartRequest *request = [[WGShopCartRequest alloc] init];
    if (pulling) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGShopCartResponse class] success:^(JHResponse *response) {
        [weakSelf handleShopCartListResponse:(WGShopCartResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleShopCartListResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleShopCartListResponse:(WGShopCartResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
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
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:_data.goods];
            [array addObjectsFromArray:response.data.goods];
            _data.goods = array;
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end