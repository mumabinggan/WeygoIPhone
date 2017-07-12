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
    WeakSelf;
    [self loadHomeTabTitlesOnCompletion:^(WGBenefitTabResponse *response) {
        [weakSelf handleBenefitTabTitles:response];
    }];
}

- (void)loadHomeTabTitlesOnCompletion:(void (^)(WGBenefitTabResponse *))completion {
    if (!_hadReadTitlesCache) {
        _dataResponse = [[WGBenefitTabResponse alloc] initWithJSON:[[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsBenefitTitlesCache]];
        if (_dataResponse) {
            if (completion) {
                completion(_dataResponse);
            }
        }
        _hadReadTitlesCache = YES;
    }
    WGBenefitTabRequest *request = [[WGBenefitTabRequest alloc] init];
    if (_dataResponse) {
        request.showsLoadingView = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGBenefitTabResponse class] success:^(JHResponse *response) {
        if (completion) {
            completion((WGBenefitTabResponse *)response);
        }
        //[weakSelf handleBenefitTabTitles:(WGBenefitTabResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
        //[self testTitle];
    }];
}

- (void)handleBenefitTabTitles:(WGBenefitTabResponse *)response {
    if (response.success) {
        _dataResponse = response;
        [[JHLocalSettings sharedSettings] setSettings:_dataResponse.toJSONString forKey:kLocalSettingsBenefitTitlesCache];
        [self addTitleSegmentView];
        [self addContentsScrollView];
        [self refreshContent:_titleSegmentView.selectedIndex cacheType:WGCacheTypeNetwork];
        //[self initTabContentDictionary];
        //[self refreshContent:0];
        //[self loadContentWithIndex:0 isFirst:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
