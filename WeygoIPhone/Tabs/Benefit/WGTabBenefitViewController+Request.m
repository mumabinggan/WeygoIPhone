//
//  WGTabBenefitViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController+Request.h"
#import "WGBenefitTabRequest.h"
#import "WGBenefitTabResponse.h"
#import "WGTabBenefitViewController+Scroll.h"
#import "WGTabBenefitViewController+Segment.h"
#import "WGTabBenefitViewController+Contents.h"

@implementation WGTabBenefitViewController (Request)

- (void)loadHomeTabTitles {
    WGBenefitTabRequest *request = [[WGBenefitTabRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGBenefitTabResponse class] success:^(JHResponse *response) {
        [weakSelf handleBenefitTabTitles:(WGBenefitTabResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
        //[self testTitle];
    }];
}

- (void)handleBenefitTabTitles:(WGBenefitTabResponse *)response {
    if (response.success) {
        [_tabContentMDictionary removeAllObjects];
        _titleArray = response.data;
        [self addTitleSegmentView];
        [self addContentsScrollView];
        [self initTabContentDictionary];
        //[self refreshContent:0];
        //[self loadContentWithIndex:0 isFirst:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
