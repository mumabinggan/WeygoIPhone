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

//- (void)initSubView {
//    [super initSubView];
//    //JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
//    //[self.view addSubview:contentView];
//    //[self addTitleSegmentView];
//    //
//    //[self addContentsScrollView];
//    
//    //[self addContentsWithIndex:0];
//    //[_contentsScrollView addSubview:[self collectionView]];
//}

- (void)setCurrentId:(long long)currentId {
    for (int num = 0; num < _titleArray.count; ++num) {
        WGTitleItem *item = _titleArray[num];
        if (item.id == currentId) {
            [self setContentsScrollViewOffsetWithIndex:currentId];
            return;
        }
    }
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
