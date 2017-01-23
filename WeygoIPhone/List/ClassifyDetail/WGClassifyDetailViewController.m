//
//  WGClassifyDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailViewController.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGHomeFloorGoodGridItemCell.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGScrollImageView.h"
#import "WGClassifySortView.h"
#import "WGHomeTitleView.h"
#import "WGSubClassifyView.h"
#import "WGClassifyDetailFilterViewController.h"

//for test
#import "WGCarouselFigureItem.h"
#import "WGClassifyItem.h"

@interface WGClassifyDetailViewController ()
{
    WGClassifySortView *_sortView;
    TWRefreshTableView *_tableView;
    
    BOOL _isGrid;
    
    WGSubClassifyView *_subClassifyView;
    
    JHView *_sortPickerBgView;
    UIPickerView *_sortPickerView;
    
    NSArray *_sortArray;
}
@end

@interface WGClassifyDetailViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@interface WGClassifyDetailViewController (PickerViewDelegate) <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation WGClassifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _data = [[WGClassifyDetail alloc] init];
    _data.name = @"AFDSFSA";
    _data.id = 213121;
    WGCarouselFigureItem *carouselFigureItem = [[WGCarouselFigureItem alloc] init];
    carouselFigureItem.pictureURL = @"http://www.pp3.cn/uploads/201610/2016100805.jpg";
    _data.carouselFigureItem = carouselFigureItem;
    
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
    _data.subClassifyArray = @[item, item2, item3, item4, item5];
    
    _data.goodArray = [self getGoodArray:8];
    
    _sortType = LFClassifySortTypeDefault;
}

- (NSArray *)getGoodArray:(NSInteger)count {
    NSMutableArray *subMArray = [NSMutableArray array];
    for (int num = 0; num < count; ++num) {
        WGHomeFloorContentGoodItem *subItem = [[WGHomeFloorContentGoodItem alloc] init];
        subItem.name = [NSString stringWithFormat:@"name_%d", num];
        subItem.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
        subItem.price = 98.32;
        subItem.currentPrice = 43.32;
        [subMArray addObject:subItem];
    }
    return subMArray;
}

- (void)initSubView {
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    [self initNavigationItem];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -35, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    
    //request return rent it
    [self createHeaderView];
}

- (void)createHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(176 + 44))];
    
    WGScrollImageView *scrollImageView = [[WGScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(176)) imageArray:@[_data.carouselFigureItem.pictureURL]];
    __weak id weakSelf = self;
    scrollImageView.onClick = ^(NSInteger index) {
        [weakSelf handleClick:index];
    };
    [headerView addSubview:scrollImageView];
    
    _sortView = [[WGClassifySortView alloc] initWithFrame:CGRectMake(0, scrollImageView.maxY, kDeviceWidth, kAppAdaptHeight(44))];
    _sortView.backgroundColor = kWhiteColor;
    _sortView.onApply = ^(NSInteger index) {
        [weakSelf handleSortApply:index];
    };
    [headerView addSubview:_sortView];
    
    _tableView.tableHeaderView = headerView;
}

- (void)handleClick:(NSInteger)index {
    
}

- (void)handleSortApply:(NSInteger)index {
    if (index == 0) {
        if (!_sortArray) {
            _sortArray = @[kStr(@"Default Sort"), kStr(@"Brand Sort"), kStr(@"Price Sort")];
        }
        [self openPickerView];
    }
    else if (index == 1) {
        [self removePickerView];
        //to another page
        WGClassifyDetailFilterViewController *classifyDetailFilterViewController = [[WGClassifyDetailFilterViewController alloc] init];
        if (_filter) {
            classifyDetailFilterViewController.currentFilterCondition = _filter;
        }
        else {
            classifyDetailFilterViewController.classifyId = _classifyId;
        }
        __weak id weakSelf = self;
        classifyDetailFilterViewController.onApply = ^(WGClassifyFilterCondition *filter) {
            [weakSelf handleFilterApply:filter];
        };
        [self.navigationController pushViewController:classifyDetailFilterViewController animated:YES];
    }
    else if (index == 2) {
        [self removePickerView];
        _isGrid = !_isGrid;
        [_sortView setItemSelected:_isGrid index:index];
        [_tableView reloadData];
    }
}

- (void)openPickerView {
    if (_sortPickerView) {
        [self removePickerView];
    }
    else {
        _sortPickerBgView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(160), kDeviceWidth, kAppAdaptHeight(160))];
        _sortPickerBgView.backgroundColor = kGrayColor;
        [self.view addSubview:_sortPickerBgView];
        
        _sortPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(30), kDeviceWidth, kAppAdaptHeight(130))];
        _sortPickerView.backgroundColor = kRGB(244, 244, 244);
        _sortPickerView.delegate = self;
        _sortPickerView.dataSource = self;
        _sortPickerView.showsSelectionIndicator = YES;
        [_sortPickerView selectRow:_sortType inComponent:0 animated:NO];
        [_sortPickerBgView addSubview:_sortPickerView];
        
        JHButton *cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), 0, kAppAdaptWidth(100), kAppAdaptHeight(30))];
        [cancelBtn setTitle:kStr(@"Cancel Sort") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = kAppAdaptFont(14);
        [_sortPickerBgView addSubview:cancelBtn];
        
        JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(108), 0, kAppAdaptWidth(100), kAppAdaptHeight(30))];
        [confirmBtn setTitle:kStr(@"Confirm Sort") forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.titleLabel.font = kAppAdaptFont(14);
        [_sortPickerBgView addSubview:confirmBtn];
    }
}

- (void)touchCancelBtn:(JHButton *)sender {
    [self removePickerView];
}

- (void)removePickerView {
    [_sortPickerBgView removeFromSuperview];
    _sortPickerBgView = nil;
    [_sortPickerView removeFromSuperview];
    _sortPickerView = nil;
}

- (void)touchConfirmBtn:(JHButton *)sender {
    NSInteger index = [_sortPickerView selectedRowInComponent:0];
    _sortType = index;
    [_sortView setItemSelected:NO title:_sortArray[index] index:0];
    [self removePickerView];
    //request data
}

- (void)handleFilterApply:(WGClassifyFilterCondition *)filter {
    _filter = filter;
    [_sortView setItemSelected:[_filter hasSelected] index:1];
}

- (void)initNavigationItem {
    if (_data && _data.subClassifyArray && _data.subClassifyArray.count > 0) {
        WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
        [titleView setTitle:_data.name];
        __weak id weakSelf = self;
        titleView.onTouch = ^(WGHomeTitleView *titleView) {
            [weakSelf touchTitleView];
        };
        self.navigationItem.titleView = titleView;
    }
    else {
        self.title = _data.name;
    }
    
    JHButton *cartBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"right_cart"] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(touchShopCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartBtn];
}

- (void)touchTitleView {
    _subClassifyView = [[WGSubClassifyView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _subClassifyView.classifyArray = _data.subClassifyArray;
    __weak id weakSelf = self;
    _subClassifyView.onApply = ^(WGClassifyItem *item) {
        [weakSelf handleApply:item];
    };
    [_subClassifyView show];
}

- (void)handleApply:(WGClassifyItem *)item {
    
}

- (void)touchShopCartBtn:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGClassifyDetailViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_data && _data.goodArray) ? ((_isGrid) ? (_data.goodArray.count + 1) / 2 : _data.goodArray.count) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isGrid ? kAppAdaptHeight(320) : kAppAdaptHeight(124);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [NSString stringWithFormat:@"cellId_%d", _isGrid];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (_isGrid) {
            cell = [[WGHomeFloorGoodGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else {
            cell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
            line.backgroundColor = WGAppSeparateLineColor;
            [cell.contentView addSubview:line];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_isGrid) {
        NSInteger index = indexPath.row * 2;
        NSMutableArray *array = [NSMutableArray arrayWithObjects:_data.goodArray[index], nil];
        if (index + 1 < _data.goodArray.count) {
            [array addObject:_data.goodArray[index + 1]];
        }
        [cell showWithArray:array];
    }
    else {
        WGHomeFloorContentGoodItem *item = _data.goodArray[indexPath.row];
        [cell showWithData:item];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isGrid) {
        //打开详情
    }
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    
}

@end

@implementation WGClassifyDetailViewController (PickerViewDelegate)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _sortArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

@end
