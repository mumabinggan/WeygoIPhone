//
//  WGTabBenefitViewController+NavigationBar.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController+NavigationBar.h"
#import "WGMainViewController.h"
#import "WGHomeTitleView.h"
#import "WGTabViewController+Slider.h"
#import "WGViewController+ShopCart.h"
#import "WGViewController+Search.h"

@implementation WGTabBenefitViewController (NavigationBar)

- (void)initNavigationItems {    
    //set leftView
    self.navigationItem.leftBarButtonItem = [self createSliderItem];
    
    //set rightView
    self.navigationItem.rightBarButtonItems = @[[self createShopCartItem], [self createSearchItem]];
}

//- (void)touchSliderButton:(id)sender {
//    WGMainViewController *mainViewController = (WGMainViewController *)self.parentViewController;
//    if ([mainViewController respondsToSelector:@selector(openSideBarViewController)]) {
//        [mainViewController openSideBarViewController];
//    }
//}

@end
