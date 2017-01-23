//
//  WGForeignTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabShopCartViewController.h"
#import "WGShopCartViewController.h"

@interface WGTabShopCartViewController ()
{
    WGShopCartViewController *_shopCartViewController;
}
@end

@implementation WGTabShopCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexForeign;
        self.tabBarItem.title = kStr(@"TabShopCart");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_cart_icon"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    self.title = kStr(@"TabShopCart");
    _shopCartViewController = [[WGShopCartViewController alloc] init];
    _shopCartViewController.view.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppTabBarHeight);
    [self.view addSubview:_shopCartViewController.view];
    [self addChildViewController:_shopCartViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
