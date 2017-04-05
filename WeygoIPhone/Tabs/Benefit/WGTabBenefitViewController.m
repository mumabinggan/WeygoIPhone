//
//  WGBenefitTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController.h"
#import "WGTabBenefitViewController+NavigationBar.h"
#import "WGCommonViewController.h"

@interface WGTabBenefitViewController ()
{
    WGCommonViewController *_contentVC;
}
@end

@implementation WGTabBenefitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexBenefit;
        self.tabBarItem.title = kStr(@"TabBenefit");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_benefit_icon"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"TabBenefit");

}

- (void)initSubView {
    [super initSubView];
    _contentVC = [[WGCommonViewController alloc] init];
    _contentVC.type = WGConfigContentTypeBenefit;
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
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
