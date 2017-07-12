//
//  WGHomeTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController.h"
//#import "WGHomeTabViewController+Segment.h"
//#import "WGHomeTabViewController+Scroll.h"
//#import "WGHomeTabViewController+Contents.h"
#import "WGCommonViewController.h"

@interface WGHomeTabViewController ()
{
    WGCommonViewController *_contentVC;
}
@end

@interface WGHomeTabViewController (CollectionDelegate) <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation WGHomeTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexHome;
        self.tabBarItem.title = kStr(@"TabHome");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_home_icon"];
        //self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-mine-highlight"];
    }
    return self;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return _viewType != 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self loadHomeTabTitles];
}

- (void)setCurrentId:(long long)currentId {
    _contentVC.currentId = currentId;
}

- (void)initData {
    //_tabContentMDictionary = [[NSMutableDictionary alloc] init];
}

- (void)initSubView {
    _contentVC = [[WGCommonViewController alloc] init];
    _contentVC.view.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppTabBarHeight);
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
