//
//  WGBaseWebViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseWebViewController.h"

@implementation WGBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBackButtonItem];
}

- (void)customBackButtonItem {
    // Custom back bar button item
    self.navigationItem.hidesBackButton = [self backBarButtonItemHidden];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self backBarButtonItemTitle] style:UIBarButtonItemStylePlain target:nil action:nil];
    if (self.navigationController.viewControllers.count>1) {
        self.navigationItem.leftBarButtonItem = [self returnMenuItem];
    }
}

- (NSString *)backBarButtonItemTitle {
    return nil;
}

- (BOOL)backBarButtonItemHidden {
    return NO;
}

- (BOOL)popViewControllerAnimated {
    return YES;
}

- (NSString *)backBarButtonItemImage {
    return @"app_return";
}

- (UIBarButtonItem *)returnMenuItem {
    JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:[self backBarButtonItemImage]]forState:UIControlStateNormal];
    [backButton setTitle:[self backBarButtonItemTitle] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleBackButton:) forControlEvents:UIControlEventTouchUpInside];
    //[backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
    [backButton sizeToFit];
    CGRect r = backButton.frame;
    r.size.height = 44;
    r.size.width += 5;
    backButton.frame = r;
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)handleBackButton:(JHButton *)sender {
    [self.navigationController popViewControllerAnimated:[self popViewControllerAnimated]];
}

@end
