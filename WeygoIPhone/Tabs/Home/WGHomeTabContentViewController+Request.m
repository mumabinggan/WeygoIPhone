//
//  WGHomeTabContentViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabContentViewController+Request.h"
#import "WGResponse.h"
#import "WGHomeTabTitleRequest.h"
#import "WGHomeTabTitleResponse.h"

@implementation WGHomeTabContentViewController (Request)

- (void)loadData {
    if (self.type == WGConfigContentTypeHome) {
        [self loadHomeTabTitles];
    }
    else if (self.type == WGConfigContentTypeBenefit) {
        [self loadBenefitTabTitles];
    }
    else if (self.type == WGConfigContentTypeAsia) {
        [self loadAsiaTabTitles];
    }
}

- (void)handleLoadData:(WGResponse *)response refresh:(BOOL)refresh {
    
}

- (void)loadHomeTabTitles {
    WGHomeTabTitleRequest *request = [[WGHomeTabTitleRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHomeTabTitleResponse class] success:^(JHResponse *response) {
        [weakSelf handleHomeTabTitles:(WGHomeTabTitleResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHomeTabTitles:(WGHomeTabTitleResponse *)response {
    if (response.success) {
        
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadBenefitTabTitles {

}

- (void)loadAsiaTabTitles {

}

//- (void)requestArticleDetail {
//    LFExploreArticleDetailRequest *request = [[LFExploreArticleDetailRequest alloc] init];
//    request.guestId = [LFApplication sharedApplication].user.guestInfo.guestId;
//    request.articleId = self.articleId;
//    request.articleDetailShowType = self.showType;
//    __weak typeof(self) weakSelf = self;
//    [self post:request forResponseClass:[LFExploreArticleDetailResponse class] onSuccess:^(TWResponse *response) {
//        [weakSelf removeRequestErrorViewFromeSuperView];
//        [weakSelf handleArticleDetailResponse:(LFExploreArticleDetailResponse *)response];
//    } onFailure:^(NSError *error) {
//        if (_isRequestEverSuccessed) {
//            [weakSelf showWarningView:kStr(@"Request Failed")];
//        }
//        else {
//            [weakSelf addRequestErrorViewWithRetry:^{
//                [weakSelf requestArticleDetail];
//            }];
//        }
//    }];
//}
//
//- (void)handleArticleDetailResponse:(LFExploreArticleDetailResponse *)response {
//    if (response.success) {
//        _isRequestEverSuccessed = YES;
//        _response = response;
//        [self refreshUI];
//    }
//    else {
//        [self showWarningView:response.message];
//    }
//}

@end
