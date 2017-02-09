//
//  WGNavigationController.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGNavigationController.h"

@interface WGNavigationController ()

@end

@implementation WGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Custom handle pop gesture recognizer
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = self.viewControllers.count>1;
    }
}

@end
