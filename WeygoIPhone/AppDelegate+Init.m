//
//  AppDelegate+Init.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/27.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "AppDelegate+Init.h"
#import "WGBaseServiceRequest.h"
#import "WGBaseServiceResponse.h"
#import "AppDelegate+UI.h"

@implementation AppDelegate (Init)

- (void)launchInitApplicatioin:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    WeakSelf
    [[WGApplication sharedApplication] loadBaseServiceOnCompletion:^(WGBaseServiceResponse *response) {
        [weakSelf handleBaseServiceResponse:application withOptions:launchOptions withResponse:(WGBaseServiceResponse *)response];
    }];
    if ([WGApplication sharedApplication].isLogined) {
        [[WGApplication sharedApplication] loadUserInfoOnCompletion:nil];
    }
}

- (void)handleBaseServiceResponse:(UIApplication *)application withOptions:(NSDictionary *)launchOptions withResponse:(WGBaseServiceResponse *)response {
    if (response.success) {
        //[self launchUIApplicatioin:application withOptions:launchOptions];
    }
    else {
        WeakSelf;
        [[JHAlert sharedAlert] showConfirmMessage:response.message withTitle:nil cancelButtonTitle:kStr(@"Exit") okButtonTitle:kStr(@"Retry") onCompletion:^(NSInteger buttonIndex, UIAlertView *alertView) {
            if (buttonIndex == 0) {
                exit(0);
            }
            else if (buttonIndex == 1) {
                [weakSelf launchInitApplicatioin:application withOptions:launchOptions];
            }
        }];
    }
}

@end
