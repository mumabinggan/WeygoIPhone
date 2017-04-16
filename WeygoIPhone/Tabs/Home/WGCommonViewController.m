//
//  WGCommonViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController.h"
#import "WGCommonViewController+Scroll.h"
#import "WGCommonViewController+Segment.h"
#import "WGCommonViewController+Contents.h"
#import "WGCommonViewController+Request.h"
#import "WGTitleItem.h"

@interface WGCommonViewController ()

@end

@implementation WGCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)initData {
    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
    _tabDataMDictionary = [[NSMutableDictionary alloc] init];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
