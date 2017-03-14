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

@implementation WGHomeSliderViewController (Request)

- (void)requestHomeSlider {
    WGHomeSliderRequest *request = [[WGHomeSliderRequest alloc] init];
    __weak id weakSelf = self;
    [self post:request forResponseClass:[WGHomeSliderResponse class] success:^(JHResponse *response) {
        [weakSelf handleHomeSliderResponse:(WGHomeSliderResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:@""];
    }];
}

- (void)handleHomeSliderResponse:(WGHomeSliderResponse *)response {
    if (response.success) {
        _data = response.data;
        [self refresh];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
