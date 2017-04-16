//
//  WGTabClassifyViewController+NavigationBar.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabClassifyViewController+NavigationBar.h"
#import "WGTabViewController+Slider.h"
#import "WGViewController+ShopCart.h"

@implementation WGTabClassifyViewController (NavigationBar)

- (void)initNavigationItems {
    //set leftView
    self.navigationItem.leftBarButtonItem = [self createSliderItem];
    
    //set rightView
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

@end
