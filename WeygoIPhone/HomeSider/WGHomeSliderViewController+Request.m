//
//  WGHomeSliderViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeSliderViewController+Request.h"
#import "WGHomeSliderRequest.h"
#import "WGHomeSliderResponse.h"
#import "WGTopicItem.h"

@implementation WGHomeSliderViewController (Request)

- (void)requestHomeSlider {
    [self setData];
    return;
    WGHomeSliderRequest *request = [[WGHomeSliderRequest alloc] init];
    __weak id weakSelf = self;
    [self post:request forResponseClass:[WGHomeSliderResponse class] success:^(JHResponse *response) {
        [weakSelf handleHomeSliderResponse:(WGHomeSliderResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:@""];
        
    }];
}

- (void)setData {
    WGHomeSlider *data = [[WGHomeSlider alloc] init];
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
    data.topics = @[topicItem, topicItem1, topicItem2, topicItem3];
    
    WGClassifyItem *item = [[WGClassifyItem alloc] init];
    item.name = @"zhenguasdf";
    item.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    item.subArray = [self getSubArray:20];
    
    WGClassifyItem *item2 = [[WGClassifyItem alloc] init];
    item2.name = @"uasdf";
    item2.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073408_255.jpg";
    item2.subArray = [self getSubArray:5];
    
    WGClassifyItem *item3 = [[WGClassifyItem alloc] init];
    item3.name = @"fsuasdf";
    item3.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073436_260.jpg";
    item3.subArray = [self getSubArray:10];
    
    WGClassifyItem *item4 = [[WGClassifyItem alloc] init];
    item4.name = @"asfsdazhenguasdf";
    item4.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073440_93.jpg";
    item4.subArray = [self getSubArray:1];
    
    WGClassifyItem *item5 = [[WGClassifyItem alloc] init];
    item5.name = @"zfjdhenguasdf";
    item5.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item5.subArray = [self getSubArray:7];
    
    WGClassifyItem *item6 = [[WGClassifyItem alloc] init];
    item6.name = @"zfjdhenguasdf";
    item6.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item6.subArray = [self getSubArray:7];
    
    data.classifys = @[item, item2, item3, item4, item5, item6];
    
    WGHomeSliderResponse *response = [[WGHomeSliderResponse alloc] init];
    response.code = @"1";
    response.data = data;
    [self handleHomeSliderResponse:response];
}


- (void)handleHomeSliderResponse:(WGHomeSliderResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
