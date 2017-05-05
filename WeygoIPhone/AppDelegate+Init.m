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
#import "AppDelegate+Fabric.h"
#import "AppDelegate+Zendesk.h"

@implementation AppDelegate (Init)

- (void)launchInitApplicatioin:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    [self initAppearance];
    [self register3rdParty];
    WeakSelf
    [[WGApplication sharedApplication] loadBaseServiceOnCompletion:^(WGBaseServiceResponse *response) {
        [weakSelf handleBaseServiceResponse:application withOptions:launchOptions withResponse:(WGBaseServiceResponse *)response];
    }];
    if ([WGApplication sharedApplication].isLogined) {
        [[WGApplication sharedApplication] loadUserInfoOnCompletion:nil];
    }
    //[[WGApplication sharedApplication] loadReceiptCountryListOnCompletion:nil];
}

- (void)handleBaseServiceResponse:(UIApplication *)application withOptions:(NSDictionary *)launchOptions withResponse:(WGBaseServiceResponse *)response {
    if (response.success) {
        [self launchUIApplicatioin:application withOptions:launchOptions];
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

- (void)register3rdParty {
#if !TARGET_IPHONE_SIMULATOR
    [self registerFabric];
    [self registerZendesk];
#endif
}

- (void)initAppearance {
    [UINavigationBar appearance].barTintColor = kHRGB(0xed7338);
    [UINavigationBar appearance].translucent = NO;
    //[UINavigationBar appearance].tintColor = kWhiteColor;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav-shadowImage"]];
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor, NSFontAttributeName:kWGOswaldRegularFont(18)}];
    
    [[UITabBar appearance] setTintColor:WGAppBaseColor];
}

@end
