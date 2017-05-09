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

- (void)loadHomeTabTitles {
    WGHomeTabTitleRequest *request = [[WGHomeTabTitleRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGHomeTabTitleResponse class] success:^(JHResponse *response) {
        [weakSelf handleHomeTabTitles:(WGHomeTabTitleResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
        //[self testTitle];
    }];
}

- (void)loadTest {
    
    WGClassifyRequest *request = [[WGClassifyRequest alloc] init];
    request.is_hot = 1;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGClassifyResponse class] success:^(JHResponse *response) {
        [weakSelf handleTestClassify:(WGClassifyResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
        //[self testTitle];
    }];
}

- (void)handleTestClassify:(WGClassifyResponse *)response {
    NSLog(@"----RESPONSE  = %@", response);
}

- (void)testTitle {
    WGHomeTabTitleResponse *response = [[WGHomeTabTitleResponse alloc] init];
    response.code = @"1";
    WGTitleItem *item = [[WGTitleItem alloc] init];
    item.id = 232332;
    item.name = @"asdfasd";
    WGTitleItem *item2 = [[WGTitleItem alloc] init];
    item2.id = 232332;
    item2.name = @"郑渊";
    WGTitleItem *item3 = [[WGTitleItem alloc] init];
    item3.id = 232332;
    item3.name = @"张文";
    response.data = @[item, item2, item3];
    [self handleHomeTabTitles:response];
}

- (void)handleHomeTabTitles:(WGHomeTabTitleResponse *)response {
    if (response.success) {
        [_tabContentMDictionary removeAllObjects];
        _titleArray = response.data;
        [self addTitleSegmentView];
        [self addContentsScrollView];
        [self initTabContentDictionary];
        [self loadContentWithIndex:0 isFirst:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadContentWithIndex:(NSInteger)index isFirst:(BOOL)isFirst {
    if (self.type == WGConfigContentTypeHome) {
        [self loadHomeContentWithIndex:index isFirst:isFirst];
    }
    else if (self.type == WGConfigContentTypeBenefit) {
    
    }
    else if (self.type == WGConfigContentTypeAsia) {
        
    }
}

- (void)loadHomeContentWithIndex:(NSInteger)index isFirst:(BOOL)isFirst {
    if (_titleArray.count > index) {
        WGTitleItem *item = _titleArray[index];
        WGHomeTabContentRequest *request = [[WGHomeTabContentRequest alloc] init];
        request.menuId = item.id;
        JHObject *object = [_tabDataMDictionary objectForKey:@(index)];
        if (object) {
            request.showsLoadingView = NO;
        }
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
            [weakSelf handleHomeContent:(WGHomeTabContentResponse *)response index:index isFirst:isFirst];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
    
}

- (void)handleHomeContent:(WGHomeTabContentResponse *)response index:(NSInteger)index isFirst:(BOOL)isFirst {
    WGHomeTabContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (contentVC) {
        [self stopRefreshing:contentVC.tableView refresh:YES pulling:YES];
    }
    if (response.success) {
        if (response.data) {
            [_tabDataMDictionary setObject:response.data forKey:@(index)];
        }
        else {
            [_tabDataMDictionary removeObjectForKey:@(index)];
        }
        [self refreshContent:index];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadBenefitTabTitles {
    
}

- (void)loadAsiaTabTitles {

}

@end
