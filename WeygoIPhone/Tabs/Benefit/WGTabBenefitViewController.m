//
//  WGBenefitTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController.h"
#import "WGTabBenefitViewController+NavigationBar.h"
#import "WGTabBenefitViewController+Scroll.h"
#import "WGTabBenefitViewController+Segment.h"
#import "WGTabBenefitViewController+Request.h"
#import "WGTitleItem.h"

@interface WGTabBenefitViewController ()
{
    //WGCommonViewController *_contentVC;
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
    [self loadHomeTabTitles];
}

- (void)initData {
    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
}

- (void)setCurrentId:(long long)currentId {
    for (int num = 0; num < _titleArray.count; ++num) {
        WGTitleItem *item = _titleArray[num];
        if (item.id == currentId) {
            [self setSelectedIndex:num];
            //[self setContentsScrollViewOffsetWithIndex:num];
            return;
        }
    }
    if (_titleArray.count > 0) {
        _currentId = 0;
    }
}

- (void)initSubView {
    [super initSubView];
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
