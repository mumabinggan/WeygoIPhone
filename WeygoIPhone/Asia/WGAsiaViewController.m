//
//  WGAsiaViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAsiaViewController.h"
#import "WGCommonViewController.h"

@interface WGAsiaViewController ()
{
    WGCommonViewController *_contentVC;
}
@end

@implementation WGAsiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    _contentVC = [[WGCommonViewController alloc] init];
    _contentVC.type = WGConfigContentTypeAsia;
    [self.view addSubview:_contentVC.view];
    [self.navigationController addChildViewController:_contentVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
