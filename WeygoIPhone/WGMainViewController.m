//
//  WGMainViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGMainViewController.h"
#import "WGHomeTabViewController.h"
#import "WGTabClassifyViewController.h"
#import "WGTabBenefitViewController.h"
#import "WGTabShopCartViewController.h"
#import "WGTabMineViewController.h"
#import "WGHomeSliderViewController.h"
#import "WGLoginViewController.h"
#import "WGTabAsiaViewController.h"
#import "WGUpdateRequest.h"
#import "WGUpdateResponse.h"

static const float kTabBarHeight = 60;

@interface WGMainViewController ()
{
    JHView *_maskView;
    WGHomeSliderViewController *_sliderController;
}
@end

@interface WGMainViewController (TabDelegate) <UITabBarControllerDelegate>

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    self.viewControllers = [NSArray arrayWithObjects:
                            [[WGHomeTabViewController alloc] init],
                            [[WGTabClassifyViewController alloc] init],
                            [[WGTabBenefitViewController alloc] init],
                            [[WGTabAsiaViewController alloc] init],
                            [[WGTabMineViewController alloc] init],
                            nil];
//    self.viewControllers = [NSArray arrayWithObjects:
//                            [[WGTabViewController alloc] init],
//                            [[WGTabViewController alloc] init],
//                            [[WGTabViewController alloc] init],
//                            [[WGTabViewController alloc] init],
//                            [[WGTabMineViewController alloc] init],
//                            nil];
//    self.tabBar.tintColor = kRedColor;
//    self.tabBar.barStyle = UIBarStyleDefault;
//    self.tabBar.backgroundColor = kWhiteColor;
    self.selectedIndex = WGTabIndexHome;
    
    [self initNotification];
    //[self setCenterTabBarItem];
    
    //[[JHAlert sharedAlert] showConfirmMessage:@"sadfasd" withTitle:@"ss" onCompletion:nil];
    
    
    
    //检查更新
    [self checkAppUpdate];
    
    WeakSelf;
    [[WGApplication sharedApplication] loadShopCartCountOnCompletion:^(WGShopCartCountResponse *response) {
        [weakSelf handleShopCartCount:response];
    }];
}

- (void)handleShopCartCount:(WGShopCartCountResponse *)response {
    if (response.success) {
        [WGApplication sharedApplication].shopCartGoodCount = response.data.goodCount;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUpdateShopCartCount object:nil];
    }
}

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLogIn:) name:kNotificationLogIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLogOut:) name:kNotificationLogOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginFail:) name:kNotificationReLoginRequired object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateShopCart:) name:kNotificationUpdateShopCartCount object:nil];
}

- (void)handleLoginFail:(NSNotification *)notification {
    [[WGApplication sharedApplication] reset];
    [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
    [WGLoginViewController pushInNavigationController:self.navigationController loginFrom:WGLoginFromDefault sucess:^(WGLoginViewController *vc) {
        [self.navigationController popViewControllerAnimated:YES];
    } cancel:^(WGLoginViewController *vc) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUpdateShopCartCount object:nil];
    return;
//    if (notification.object && [notification.object isKindOfClass:[NSDictionary class]]) {
//        NSString *message = nil;
//        if (![NSString isNullOrEmpty:[notification.object objectForKey:@"message"]]) {
//            message = [notification.object objectForKey:@"message"];
//        }
//        WeakSelf;
//        [[JHAlert sharedAlert] showConfirmMessage:message withTitle:nil cancelButtonTitle:kStr(@"Cancel") okButtonTitle:kStr(@"Ok") onCompletion:^(NSInteger buttonIndex, UIAlertView *alertView) {
//            if (buttonIndex == 0) {
//                [weakSelf loadRootViewController:nil withOptions:nil];
//            }
//            else if (buttonIndex == 1) {
//                [weakSelf openLoginViewController];
//            }
//        }];
//    }
}

- (void)handleLogIn:(NSNotification *)notification {
    [[WGApplication sharedApplication] loadShopCartCountOnCompletion:nil];
}

- (void)handleLogOut:(NSNotification *)notification {
    [[WGApplication sharedApplication] loadShopCartCountOnCompletion:nil];
}

- (void)handleUpdateShopCart:(NSNotification *)notification {
//    [self.tabBar show:[WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO index:WGTabIndexShopCart badgeNumber:[WGApplication sharedApplication].shopCartGoodCount];
}

- (void)resetViewControllersWithIndex:(NSInteger)index {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    if (array.count > index) {
        UIViewController *currentVC = (UIViewController *)array[index];
        [array replaceObjectAtIndex:index withObject:[[[currentVC class] alloc] init]];
    }
    [self setViewControllers:array animated:YES];
}

- (void)setTabbarHidden:(BOOL)hidden {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            CGRect frame = view.frame;
            frame.origin.y = hidden ? kDeviceHeight : (kDeviceHeight - kTabBarHeight);
            view.frame = frame;
        }
    }
    [UIView commitAnimations];
}

- (void)setCenterTabBarItem {
    JHButton *centerItem = [JHButton buttonWithType:UIButtonTypeCustom];
    CGSize imageSize = CGSizeMake(50, 50);
    centerItem.frame = CGRectMake((kDeviceWidth - imageSize.width)/2, (kAppTabBarHeight - kTabBarHeight), imageSize.width, kTabBarHeight);
    [centerItem setBackgroundColor:kRedColor];
    [centerItem addTarget:self action:@selector(touchCenterItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:centerItem];
}

- (void)touchCenterItem:(id)sender {
    self.selectedIndex = WGTabIndexBenefit;
}

- (void)openSideBarViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!_maskView) {
        _maskView = [[JHView alloc] initWithFrame:window.bounds];
        _maskView.backgroundColor = kBlackColor;
        _maskView.alpha = 0;
        [window addSubview:_maskView];
    }
    if (!_sliderController) {
        _sliderController = [[WGHomeSliderViewController alloc] init];
        _sliderController.view.frame = CGRectMake(-kDeviceWidth, 0, kDeviceWidth, kDeviceHeight);
        __weak typeof (self) weakSelf = self;
        _sliderController.onTouchBlankArea = ^(void) {
            [weakSelf touchSideBarBlankArea];
        };
        [window addSubview:_sliderController.view];
    }
    else {
        [_sliderController refresh];
    }
    [self setSideBarhidden:NO];
}

- (void)closeSideBarViewController {
    [self setSideBarhidden:YES];
}

- (void)touchSideBarBlankArea {
    [self setSideBarhidden:YES];
}

- (void)setSideBarhidden:(BOOL)hidden {
    _maskView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^(void) {
        _sliderController.view.frame = CGRectMake(hidden ? -kDeviceWidth : 0, 0, kDeviceWidth, kDeviceHeight);
        _maskView.alpha = hidden ? 0 : 0.3;
    } completion:^(BOOL finish) {
        if (finish) {
            _maskView.hidden = hidden;
        }
    }];
}

- (void)checkAppUpdate {
    WGUpdateRequest *request = [[WGUpdateRequest alloc] init];
    request.showsLoadingView = NO;
    WeakSelf;
    [self post:request forResponseClass:[WGUpdateResponse class] success:^(JHResponse *response) {
        [weakSelf handleAppUpdateResponse:(WGUpdateResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleAppUpdateResponse:(WGUpdateResponse *)response {
    if (response.success) {
        if (response.data.versionStatus == 1) {
            NSArray *newArray = [response.data.versionCode splitBy:@"."];
            if (newArray.count == 3) {
                int newVersionCode = ((NSString *)newArray[0]).intValue * 1000 + ((NSString *)newArray[1]).intValue * 100 + ((NSString *)newArray[2]).intValue;
                NSArray *oldArray = [kAppVersion splitBy:@"."];
                int oldVersionCode = ((NSString *)oldArray[0]).intValue * 1000 + ((NSString *)oldArray[1]).intValue * 100 + ((NSString *)oldArray[2]).intValue;
                if (newVersionCode > oldVersionCode) {
                    WeakSelf;
                    [[JHAlert sharedAlert] showConfirmMessage:response.data.updateTips withTitle:nil cancelButtonTitle:kStr(@"Mine_Logout_Cancel") okButtonTitle:kStr(@"Mine_Logout_Ok") onCompletion:^(NSInteger buttonIndex, UIAlertView *alertView) {
                        if (buttonIndex == 0) {
                            exit(0);
                        }
                        else if (buttonIndex == 1) {
                            [weakSelf skipToUpdateURL:response.data.linkUrl];
                        }
                    }];
                }
            }
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)skipToUpdateURL:(NSString *)linkURL {
    if (![NSString isNullOrEmpty:linkURL]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkURL]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
