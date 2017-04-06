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

@implementation WGGoodDetailViewController (Request)

- (void)initData {
//    _goodDetail = [[WGGoodDetail alloc] init];
//    WGCarouselFigureItem *carouseItem = [[WGCarouselFigureItem alloc] init];
//    carouseItem.pictureURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//    _goodDetail.carouselFigures = @[carouseItem];
//    
//    _goodDetail.name = @"sdafsad";
//    _goodDetail.price = @"2334.33";
//    _goodDetail.currentPrice = @"434.43";
//    
//    _goodDetail.productInfo = @"显示经纪人头像（好经纪人带特定图标，以UED稿为准）、姓名、所属公司简称（小区合伙人优先显示为“小";
//    _goodDetail.deliveryInfo = @"成交套数：取自新筋斗云“经纪人运营系统”，如果有人工配置的成交套数取人工配置数值，如果无人工配置数值取系统记录的数值，如都为0，则隐藏该字段成交套数：取自新筋斗云“经纪人运营系统”，如果有人工配置的成交套数取人工配置数值，如果无人工配置数值取系统记录的数值，如都为0，则隐藏该字段";
//    _goodDetail.commodityInfo = @"成交套数：取自新筋斗云“经纪人运营系统”，如果有人工配置的成交套数取人工配置数值，如果无人工配置数值取系统记录的数值，如都为0，则隐藏该字段成交套数：取自新筋斗云“经纪人运营系统”，如果有人工配置的成交套数取人工配置数值，如果无人工配置数值取系统记录的数值，如都为0，则隐藏该字段";
//    WGGoodDetailDesItem *item = [[WGGoodDetailDesItem alloc] init];
//    item.name = @"名字";
//    item.value = @"郑渊说";
//    
//    WGGoodDetailDesItem *item1 = [[WGGoodDetailDesItem alloc] init];
//    item1.name = @"姓别";
//    item1.value = @"男";
//    _goodDetail.productDes = @[item, item1];
//    
//    WGHomeFloorContentItem *floorItem3 = [[WGHomeFloorContentItem alloc] init];
//    floorItem3.type = WGHomeFloorItemTypeGoodColumn;
//    floorItem3.name = @"zhengyuanqian";
//    floorItem3.chineseName = @"郑渊谦";
//    floorItem3.briefDescription = @"天生性情温驯，毛色有纯色、";
//    floorItem3.price = @"12.3";
//    floorItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    floorItem3.discount = 0.3;
//    floorItem3.reducePrice = @"2.3";
//    floorItem3.currentPrice = @"10.1";
//    
//    WGHomeFloorContentItem *floorItem4 = [[WGHomeFloorContentItem alloc] init];
//    floorItem4.type = WGHomeFloorItemTypeGoodColumn;
//    floorItem4.name = @"zhengyuanqian";
//    floorItem4.chineseName = @"渊谦";
//    floorItem4.briefDescription = @"天生性情温驯，毛色有纯色、";
//    floorItem4.price = @"12.3";
//    floorItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    floorItem4.discount = 0.3;
//    floorItem4.reducePrice = @"2.3";
//    floorItem4.currentPrice = @"10.1";
//    
//    WGHomeFloorContentItem *floorItem5 = [[WGHomeFloorContentItem alloc] init];
//    floorItem5.type = WGHomeFloorItemTypeGoodColumn;
//    floorItem5.name = @"zhengyuanqian";
//    floorItem5.chineseName = @"郑谦";
//    floorItem5.briefDescription = @"天生性情温驯，毛色有纯色、";
//    floorItem5.price = @"12.3";
//    floorItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    floorItem5.discount = 0.3;
//    floorItem5.reducePrice = @"2.3";
//    floorItem5.currentPrice = @"10.1";
//    _goodDetail.recommendProduce = @[floorItem3, floorItem4, floorItem5];
//    
//    [_tableView reloadData];
}

- (void)loadGoodDetail {
    WGGoodDetailRequest *request = [[WGGoodDetailRequest alloc] init];
    request.id = self.goodId;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGGoodDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleGoodDetailResponse:(WGGoodDetailResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleGoodDetailResponse:(WGGoodDetailResponse *)response {
    if (response.success) {
        _goodDetail = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)requestCollectGood:(BOOL)collect {
    if (collect) {
        WGCollectGoodRequest *request = [[WGCollectGoodRequest alloc] init];
        request.productId = self.goodId;
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
