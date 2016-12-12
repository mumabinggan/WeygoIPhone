//
//  WGMainViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGMainViewController.h"
#import "WGHomeTabViewController.h"
#import "WGClassifyTabViewController.h"
#import "WGBenefitTabViewController.h"
#import "WGForeignTabViewController.h"
#import "WGMineTabViewController.h"

static const float kTabBarHeight = 60;

@interface WGMainViewController ()

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllers = [NSArray arrayWithObjects:
                            [[WGHomeTabViewController alloc] init],
                            [[WGClassifyTabViewController alloc] init],
                            [[WGBenefitTabViewController alloc] init],
                            [[WGForeignTabViewController alloc] init],
                            [[WGMineTabViewController alloc] init],
                            nil];
//    self.tabBar.tintColor = kRedColor;
//    self.tabBar.barStyle = UIBarStyleDefault;
//    self.tabBar.backgroundColor = kWhiteColor;
    self.selectedIndex = WGTabIndexHome;
    
    [self setCenterTabBarItem];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
