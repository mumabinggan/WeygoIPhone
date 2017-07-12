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
    //_tabDataMDictionary = [[NSMutableDictionary alloc] init];
}

- (void)setCurrentId:(long long)currentId {
    NSArray *array = _dataResponse.data;
    for (int num = 0; num < array.count; ++num) {
        WGTitleItem *item = array[num];
        if (item.id == currentId) {
            [self setSelectedIndex:num];
            //[self setContentsScrollViewOffsetWithIndex:num];
            return;
        }
    }
    if (array.count > 0) {
        _currentId = 0;
    }
}

- (long)menuIdWithIndex:(NSInteger)index {
    WGTitleItem *item = [self dataWithIndex:index];
    if (item) {
        return item.id;
    }
    return -1;
}

- (WGTitleItem *)dataWithMenuId:(long)menuId {
    NSArray *array = _dataResponse.data;
    for (int num = 0; num < array.count; ++num) {
        WGTitleItem *item = array[num];
        if (item.id == menuId) {
            return item;
        }
    }
    return nil;
}

- (NSInteger)indexWithMenuId:(long)menuId {
    NSArray *array = _dataResponse.data;
    for (int num = 0; num < array.count; ++num) {
        WGTitleItem *item = array[num];
        if (item.id == menuId) {
            return num;
        }
    }
    return 0;
}

- (WGTitleItem *)dataWithIndex:(NSInteger)index {
    if (_dataResponse.data.count <= index) {
        index = 0;
    }
    WGTitleItem *item = _dataResponse.data[index];
    return item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
