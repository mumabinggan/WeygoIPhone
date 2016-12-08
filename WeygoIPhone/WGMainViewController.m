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
    self.tabBar.tintColor = WGAppBaseColor;
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.backgroundColor = kWhiteColor;
//    if (IOS8) {
//        self.tabBar.translucent = YES;
//    }
//    else {
//        self.tabBar.translucent = NO;
//    }
    self.selectedIndex = WGTabIndexHome;
    
}

- (void)setViewControllers {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
