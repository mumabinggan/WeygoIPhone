//
//  WGGoodDetailViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetailViewController+Request.h"
#import "WGCarouselFigureItem.h"
#import "WGHomeFloorContentItem.h"
#import "WGCollectGoodRequest.h"
#import "WGCollectGoodResponse.h"
#import "WGCancelCollectGoodRequest.h"
#import "WGCancelCollectGoodResponse.h"
#import "WGAddGoodToCartRequest.h"
#import "WGAddGoodToCartResponse.h"
#import "WGGoodDetailRecommendRequest.h"
#import "WGGoodDetailRecommendResponse.h"

@implementation WGGoodDetailViewController (Request)

- (void)loadGoodDetail {
    WGGoodDetailRequest *request = [[WGGoodDetailRequest alloc] init];
    request.id = self.goodId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGGoodDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleGoodDetailResponse:(WGGoodDetailResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleGoodDetailResponse:(WGGoodDetailResponse *)response {
    if (response.success) {
        _goodDetail = response.data;
        _goodDetail.recommendProduce = _recommendGoods;
        //_goodDetail.productDes = nil;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadGoodDetailRecommend {
    WGGoodDetailRecommendRequest *request = [[WGGoodDetailRecommendRequest alloc] init];
    request.goodId = self.goodId;
    request.showsLoadingView = NO;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGGoodDetailRecommendResponse class] success:^(JHResponse *response) {
        [weakSelf handleGoodDetailRecommendResponse:(WGGoodDetailRecommendResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleGoodDetailRecommendResponse:(WGGoodDetailRecommendResponse *)response {
    if (response.success) {
        _recommendGoods = response.data;
        if (_goodDetail) {
            _goodDetail.recommendProduce = _recommendGoods;
            [self refreshUI];
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)requestCollectGood:(BOOL)collect {
    if (collect) {
        WGCollectGoodRequest *request = [[WGCollectGoodRequest alloc] init];
        request.productId = self.goodId;
        request.showsLoadingView = NO;
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGCollectGoodResponse class] success:^(JHResponse *response) {
            [weakSelf handleCollectGoodResponse:(WGCollectGoodResponse *)response];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
    else {
        WGCancelCollectGoodRequest *request = [[WGCancelCollectGoodRequest alloc] init];
        request.id = _goodDetail.favoritedId;
        request.showsLoadingView = NO;
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGCancelCollectGoodResponse class] success:^(JHResponse *response) {
            [weakSelf handleCancelCollectGoodResponse:(WGCancelCollectGoodResponse *)response];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
}

- (void)handleCollectGoodResponse:(WGCollectGoodResponse *)response {
    if (response.success) {
        _goodDetail.hasFavorited = response.data.favoriteId;
        [self refreshBottomView];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)handleCancelCollectGoodResponse:(WGCancelCollectGoodResponse *)response {
    if (response.success) {
        _goodDetail.hasFavorited = 0;
        [self refreshBottomView];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
