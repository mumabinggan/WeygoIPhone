//
//  WGClassifyDetailFilterViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailFilterViewController.h"
#import "WGClassifyFilterCondition.h"
#import "WGClassifyKeywordView.h"
#import "WGClassifyKeyword.h"
#import "WGClassifyItem.h"
#import "WGClassifyFitlerClassifyView.h"
#import "WGClassifyDetailFilterViewController+Request.h"

@interface WGClassifyDetailFilterViewController ()
{
    JHView *_contentView;
    JHScrollView *_scrollView;
    NSArray *_classifyViewArray;
}
@end

@implementation WGClassifyDetailFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_currentFilterCondition) {
        [self loadClassifyDetailFilter];
    }
}

- (void)setCurrentFilterCondition:(WGClassifyFilterCondition *)currentFilterCondition {
    _currentFilterCondition = currentFilterCondition;
    _data = currentFilterCondition;
}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"Classify Filter");
    _contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    if (_currentFilterCondition) {
        [self refreshView];
    }
}

- (void)initNavigationItem {
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [okBtn setBackgroundImage:[UIImage imageNamed:@"classify_detail_filter_commit"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchOkBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
}

- (void)touchOkBtn:(id)sender {
    //create filter
    if (self.onApply) {
        self.onApply(_data);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshView {
    
    [self initNavigationItem];
    
    _scrollView = [[JHScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.alwaysBounceVertical = YES;
    if (!_currentFilterCondition) {
        _scrollView.contentInset = UIEdgeInsetsMake(kAppNavigationVCY, 0, 0, 0);
    }
    [_contentView addSubview:_scrollView];
    
    WGClassifyKeywordView *keyworkView = nil;
    if (_data && _data.keyWordArray != nil && _data.keyWordArray.count != 0) {
        JHView *sectionView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(40))];
        sectionView.backgroundColor = kRGBA(0, 0, 0, 0.12);
        [_scrollView addSubview:sectionView];
        
        JHLabel *sectionTitleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kAppAdaptWidth(200), sectionView.height)];
        sectionTitleLabel.font = kAppAdaptFont(14);
        sectionTitleLabel.textColor = WGAppNameLabelColor;
        sectionTitleLabel.text = kStr(@"Brand");
        [sectionView addSubview:sectionTitleLabel];
        
        keyworkView = [[WGClassifyKeywordView alloc] initWithFrame:CGRectMake(0, sectionView.maxY, kDeviceWidth, 1) disArray:_data.keyWordArray];
        [_scrollView addSubview:keyworkView];
    }
    
    WGClassifyKeywordView *classifyView = nil;
    if (_data && _data.classifyArray != nil && _data.classifyArray.count != 0) {
        JHView *sectionView = [[JHView alloc] initWithFrame:CGRectMake(0, keyworkView.maxY, kDeviceWidth, kAppAdaptHeight(40))];
        sectionView.backgroundColor = kRGBA(0, 0, 0, 0.12);
        [_scrollView addSubview:sectionView];
        
        JHLabel *sectionTitleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kAppAdaptWidth(200), sectionView.height)];
        sectionTitleLabel.font = kAppAdaptFont(14);
        sectionTitleLabel.textColor = WGAppNameLabelColor;
        sectionTitleLabel.text = kStr(@"classify_filter_classifyname");
        [sectionView addSubview:sectionTitleLabel];
        
        classifyView = [[WGClassifyKeywordView alloc] initWithFrame:CGRectMake(0, sectionView.maxY, kDeviceWidth, 1) disArray:_data.classifyArray];
        [_scrollView addSubview:classifyView];
    }
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, classifyView.maxY);
    
//    NSMutableArray *classifyViewMArray = [NSMutableArray array];
//    NSInteger count = _data.classifyArray.count;
//    for (int num = 0; num < count; ++num) {
//        WGClassifyFitlerClassifyView *itemView = [[WGClassifyFitlerClassifyView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8) + kAppAdaptWidth(122) * (num%3), keyworkView.maxY + kAppAdaptHeight(122) * (num/3), kAppAdaptHeight(114), kAppAdaptHeight(114))];
//        itemView.backgroundColor = kHRGB(0xF8FAFA);
//        [itemView showWithData:_data.classifyArray[num]];
//        [_scrollView addSubview:itemView];
//        [classifyViewMArray addObject:itemView];
//    }
//    _classifyViewArray = classifyViewMArray;
//    _scrollView.contentSize = CGSizeMake(kDeviceWidth, keyworkView.maxY + (count + 2)/3 * kAppAdaptHeight(122));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
