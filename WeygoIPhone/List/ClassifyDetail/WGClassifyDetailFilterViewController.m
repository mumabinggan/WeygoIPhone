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
}

- (void)initData {
    _data = [[WGClassifyFilterCondition alloc] init];
    
    WGClassifyKeyword *keyword = [[WGClassifyKeyword alloc] init];
    keyword.id = 2233;
    keyword.name = @"zheng1";
    
    WGClassifyKeyword *keyword2 = [[WGClassifyKeyword alloc] init];
    keyword2.id = 2233;
    keyword2.name = @"zheng02";
    
    WGClassifyKeyword *keyword3 = [[WGClassifyKeyword alloc] init];
    keyword3.id = 2233;
    keyword3.name = @"zheng003";
    
    _data.keyWordArray = @[keyword, keyword2, keyword3];
    
    WGClassifyItem *item = [[WGClassifyItem alloc] init];
    item.name = @"zhenguasdf";
    item.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    
    WGClassifyItem *item2 = [[WGClassifyItem alloc] init];
    item2.name = @"uasdf";
    item2.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073408_255.jpg";
    
    WGClassifyItem *item3 = [[WGClassifyItem alloc] init];
    item3.name = @"fsuasdf";
    item3.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073436_260.jpg";
    
    WGClassifyItem *item4 = [[WGClassifyItem alloc] init];
    item4.name = @"asfsdazhenguasdf";
    item4.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073440_93.jpg";
    
    WGClassifyItem *item5 = [[WGClassifyItem alloc] init];
    item5.name = @"zfjdhenguasdf";
    item5.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    
    _data.classifyArray = @[item, item2, item3, item4, item5];
    
    if (_currentFilterCondition) {
        _data = _currentFilterCondition;
    }
    else {
        //request 
    }
}

- (void)initSubView {
    self.title = kStr(@"Classify Filter");
    _contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    [self refreshView];
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
    [_contentView addSubview:_scrollView];
    
    JHView *sectionView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(40))];
    sectionView.backgroundColor = kRGBA(0, 0, 0, 0.12);
    [_scrollView addSubview:sectionView];
    
    JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(8), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    imageView.image = [UIImage imageNamed:@"brand_icon"];
    [sectionView addSubview:imageView];
    
    JHLabel *sectionTitleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(imageView.maxX + kAppAdaptWidth(8), 0, kAppAdaptWidth(200), sectionView.height)];
    sectionTitleLabel.font = kAppAdaptFont(14);
    sectionTitleLabel.textColor = WGAppNameLabelColor;
    sectionTitleLabel.text = kStr(@"Brand");
    [sectionView addSubview:sectionTitleLabel];
    
    WGClassifyKeywordView *keyworkView = [[WGClassifyKeywordView alloc] initWithFrame:CGRectMake(0, sectionView.maxY, kDeviceWidth, 1) disArray:_data.keyWordArray];
    [_scrollView addSubview:keyworkView];
    
    NSMutableArray *classifyViewMArray = [NSMutableArray array];
    NSInteger count = _data.classifyArray.count;
    for (int num = 0; num < count; ++num) {
        WGClassifyFitlerClassifyView *itemView = [[WGClassifyFitlerClassifyView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8) + kAppAdaptWidth(122) * (num%3), keyworkView.maxY + kAppAdaptHeight(122) * (num/3), kAppAdaptHeight(114), kAppAdaptHeight(114))];
        [itemView showWithData:_data.classifyArray[num]];
        [_scrollView addSubview:itemView];
        [classifyViewMArray addObject:itemView];
    }
    _classifyViewArray = classifyViewMArray;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, keyworkView.maxY + (count + 2)/3 * kAppAdaptHeight(122));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
