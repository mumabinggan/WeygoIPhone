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
        __weak typeof(self) weakSelf = self;
        [self post:request forResponseClass:[WGHomeTabContentResponse class] success:^(JHResponse *response) {
            [weakSelf handleHomeContent:(WGHomeTabContentResponse *)response index:index isFirst:isFirst];
        } failure:^(NSError *error) {
            [weakSelf showWarningMessage:kStr(@"Request Failed")];
        }];
    }
    
}

- (void)handleHomeContent:(WGHomeTabContentResponse *)response index:(NSInteger)index isFirst:(BOOL)isFirst {
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

//- (void)loadHomeTabTitles {
//    WGHomeTabTitleRequest *request = [[WGHomeTabTitleRequest alloc] init];
//    __weak typeof(self) weakSelf = self;
//    [self post:request forResponseClass:[WGHomeTabTitleResponse class] success:^(JHResponse *response) {
//        [weakSelf handleHomeTabTitles:(WGHomeTabTitleResponse *)response];
//    } failure:^(NSError *error) {
//        [weakSelf showWarningMessage:kStr(@"Request Failed")];
//    }];
//}
//
//- (void)handleHomeTabTitles:(WGHomeTabTitleResponse *)response {
//    if (response.success) {
//        [self addTitleSegmentView];
//    }
//    else {
//        [self showWarningMessage:response.message];
//    }
//}


- (WGHome *)setData {
    WGHome *_homeData = [[WGHome alloc] init];
    
    //carouselFigureArray
    WGCarouselFigureItem *carouselFigureItem = [[WGCarouselFigureItem alloc] init];
    carouselFigureItem.pictureURL = @"http://www.pp3.cn/uploads/201610/2016100805.jpg";
    
    WGCarouselFigureItem *carouselFigureItem1 = [[WGCarouselFigureItem alloc] init];
    carouselFigureItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016090809.jpg";
    _homeData.carouselFigures = @[carouselFigureItem, carouselFigureItem1];
    
    //WGTopicItem
    WGTopicItem *topicItem = [[WGTopicItem alloc] init];
    topicItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016090910.jpg";
    topicItem.name = @"zheng";
    WGTopicItem *topicItem1 = [[WGTopicItem alloc] init];
    topicItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    topicItem1.name = @"zhengyuan";
    WGTopicItem *topicItem2 = [[WGTopicItem alloc] init];
    topicItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    topicItem2.name = @"zhengyuanqian";
    WGTopicItem *topicItem3 = [[WGTopicItem alloc] init];
    topicItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    topicItem3.name = @"zhengyuanqian haha";
    _homeData.topics = @[topicItem, topicItem1, topicItem2, topicItem3];;
    
    //New
    WGNewsItem *newItem1 = [[WGNewsItem alloc] init];
    newItem1.name = @"How do you return a multiline text CGSize from the new iOS 7 method sizeW";
    WGNewsItem *newItem2 = [[WGNewsItem alloc] init];
    newItem2.name = @"CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName : [UIFon";
    WGNewsItem *newItem3 = [[WGNewsItem alloc] init];
    newItem3.name = @"or the first time i see this notation for di";
    WGNewsItem *newItem4 = [[WGNewsItem alloc] init];
    newItem4.name = @"Have a look at this: stackoverflow.com/question";
    WGNews *news = [[WGNews alloc] init];
    news.name = @"好消息";
    news.contents = @[newItem1, newItem2, newItem3, newItem4];
    _homeData.news = news;
    
    WGHomeFloorItem *floor = [[WGHomeFloorItem alloc] init];
    floor.type = WGHomeFloorItemTypeGoodList;
    floor.name = @"郑渊谦";
    floor.breifDescription = @"IOS 开发工程师";
    floor.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem = [[WGHomeFloorContentItem alloc] init];
    floorItem.name = @"zhengyuanqian";
    floorItem.chineseName = @"郑渊谦";
    floorItem.briefDescription = @"fdfasdfasdfasdf asfdaad";
    floorItem.price = @"12.3";
    floorItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem.discount = 0.3;
    floorItem.reducePrice = @"2.3";
    floorItem.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem1 = [[WGHomeFloorContentItem alloc] init];
    floorItem1.name = @"zhengyuanqian";
    floorItem1.chineseName = @"渊谦";
    floorItem1.briefDescription = @"fdfasdfasdfasdf";
    floorItem1.price = @"12.3";
    floorItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem1.discount = 0.3;
    floorItem1.reducePrice = @"2.3";
    floorItem1.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem2 = [[WGHomeFloorContentItem alloc] init];
    floorItem2.name = @"zhengyuanqian";
    floorItem2.chineseName = @"郑谦";
    floorItem2.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem2.price = @"12.3";
    floorItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem2.discount = 0.3;
    floorItem2.reducePrice = @"2.3";
    floorItem2.currentPrice = @"10.1";
    floor.contents = @[floorItem, floorItem1, floorItem2];
    
    WGHomeFloorItem *floor1 = [[WGHomeFloorItem alloc] init];
    floor1.type = WGHomeFloorItemTypeGoodColumn;
    floor1.name = @"郑渊谦";
    floor1.breifDescription = @"IOS 开发工程师";
    floor1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem3 = [[WGHomeFloorContentItem alloc] init];
    floorItem3.name = @"zhengyuanqian";
    floorItem3.chineseName = @"郑渊谦";
    floorItem3.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem3.price = @"12.3";
    floorItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem3.discount = 0.3;
    floorItem3.reducePrice = @"2.3";
    floorItem3.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem4 = [[WGHomeFloorContentItem alloc] init];
    floorItem4.name = @"zhengyuanqian";
    floorItem4.chineseName = @"渊谦";
    floorItem4.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem4.price = @"12.3";
    floorItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem4.discount = 0.3;
    floorItem4.reducePrice = @"2.3";
    floorItem4.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem5 = [[WGHomeFloorContentItem alloc] init];
    floorItem5.name = @"zhengyuanqian";
    floorItem5.chineseName = @"郑谦";
    floorItem5.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem5.price = @"12.3";
    floorItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem5.discount = 0.3;
    floorItem5.reducePrice = @"2.3";
    floorItem5.currentPrice = @"10.1";
    floor1.contents = @[floorItem3, floorItem4, floorItem5];
    
    WGHomeFloorItem *floor2 = [[WGHomeFloorItem alloc] init];
    floor2.type = WGHomeFloorItemTypeGoodGrid;
    floor2.name = @"郑渊谦";
    floor2.breifDescription = @"IOS 开发工程师";
    floor2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem6 = [[WGHomeFloorContentItem alloc] init];
    floorItem6.name = @"zhengyuanqian";
    floorItem6.chineseName = @"郑渊谦";
    floorItem6.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem6.price = @"12.3";
    floorItem6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem6.discount = 0.3;
    floorItem6.reducePrice = @"2.3";
    floorItem6.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem7 = [[WGHomeFloorContentItem alloc] init];
    floorItem7.name = @"zhengyuanqian";
    floorItem7.chineseName = @"渊谦";
    floorItem7.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem7.price = @"12.3";
    floorItem7.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem7.discount = 0.3;
    floorItem7.reducePrice = @"2.3";
    floorItem7.currentPrice = @"10.1";
    
    WGHomeFloorContentItem *floorItem8 = [[WGHomeFloorContentItem alloc] init];
    floorItem8.name = @"zhengyuanqian";
    floorItem8.chineseName = @"郑谦";
    floorItem8.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem8.price = @"12.3";
    floorItem8.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem8.discount = 0.3;
    floorItem8.reducePrice = @"2.3";
    floorItem8.currentPrice = @"10.1";
    floor2.contents = @[floorItem6, floorItem7, floorItem8];
    
    WGHomeFloorItem *floor3 = [[WGHomeFloorItem alloc] init];
    floor3.type = WGHomeFloorItemTypeCountry;
    floor3.name = @"郑渊谦";
    floor3.breifDescription = @"IOS 开发工程师";
    floor3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem9 = [[WGHomeFloorContentItem alloc] init];
    floorItem9.name = @"zhengyuanqian";
    floorItem9.chineseName = @"郑谦";
    floorItem9.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem9.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor3.contents = @[floorItem9];
    
    WGHomeFloorItem *floor4 = [[WGHomeFloorItem alloc] init];
    floor4.type = WGHomeFloorItemTypeClassifyList;
    floor4.name = @"郑渊谦";
    floor4.breifDescription = @"IOS 开发工程师";
    floor4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem10 = [[WGHomeFloorContentItem alloc] init];
    floorItem10.name = @"zhengyuanqian";
    floorItem10.chineseName = @"郑谦";
    floorItem10.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem10.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor4.contents = @[floorItem10];
    
    WGHomeFloorItem *floor5 = [[WGHomeFloorItem alloc] init];
    floor5.type = WGHomeFloorItemTypeClassifyColumn;
    floor5.name = @"郑渊谦";
    floor5.breifDescription = @"IOS 开发工程师";
    floor5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem11 = [[WGHomeFloorContentItem alloc] init];
    floorItem11.name = @"zhengyuanqian";
    floorItem11.chineseName = @"郑谦";
    floorItem11.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem11.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor5.contents = @[floorItem11];
    
    WGHomeFloorItem *floor6 = [[WGHomeFloorItem alloc] init];
    floor6.type = WGHomeFloorItemTypeClassifyGrid;
    floor6.name = @"郑渊谦";
    floor6.breifDescription = @"IOS 开发工程师";
    floor6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem12 = [[WGHomeFloorContentItem alloc] init];
    floorItem12.name = @"zhengyuanqian";
    floorItem12.chineseName = @"郑谦";
    floorItem12.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem12.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor6.contents = @[floorItem12];
    
    _homeData.floors = @[floor, floor1, floor2, floor3, floor4, floor5, floor6];
    
    return _homeData;
}

- (void)loadBenefitTabTitles {
    
}

- (void)loadAsiaTabTitles {

}

@end
