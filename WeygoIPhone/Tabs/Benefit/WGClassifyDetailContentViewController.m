//
//  WGCommonClassifyDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailContentViewController.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGHomeFloorGoodGridItemCell.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGScrollImageView.h"
#import "WGClassifySortView.h"
#import "WGHomeTitleView.h"
#import "WGSubClassifyView.h"
#import "WGClassifyDetailFilterViewController.h"
#import "WGHomeCarouselFiguresCell.h"
#import "WGClassifyDetailContentViewController+Request.h"
#import "WGHomeNewsCell.h"
#import "WGGoodDetailViewController.h"
#import "WGClassifyDetailGoodGridItemCell.h"
#import "WGPostCodePopoverView.h"
#import "WGViewController+TopButton.h"

//for test
#import "WGCarouselFigureItem.h"
#import "WGClassifyItem.h"
#import "WGNewsItem.h"

@interface WGClassifyDetailContentViewController ()
{
    WGClassifySortView *_sortView;
    
    WGSubClassifyView *_subClassifyView;
    
    JHView *_sortPickerBgView;
    UIPickerView *_sortPickerView;
    
    NSArray *_sortArray;
}
@end

@interface WGClassifyDetailContentViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@interface WGClassifyDetailContentViewController (PickerViewDelegate) <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation WGClassifyDetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData:YES pulling:NO];
}

- (void)initData {
    [super initData];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain refreshType:TWRefreshTypeBottom | TWRefreshTypeTop];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    _tableView.layer.opacity = 0.0f;
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)handleClick:(NSInteger)index {
    
}

- (void)handleSortApply:(NSInteger)index {
    if (index == 0) {
        if (!_sortArray) {
            _sortArray = @[kStr(@"Default Sort"), kStr(@"Brand Sort"), kStr(@"Price Sort Down"), kStr(@"Price Sort Up")];
        }
        [self openPickerView];
    }
    else if (index == 1) {
        [self removePickerView];
        //to another page
        WGClassifyDetailFilterViewController *classifyDetailFilterViewController = [[WGClassifyDetailFilterViewController alloc] init];
        if (_filter) {
            classifyDetailFilterViewController.classifyId = _classifyId;
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
        _closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
        [_closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setBackgroundColor:kHRGBA(0x000000, 0.5)];
        [self.view addSubview:_closeBtn];
        
        BOOL hasTab = (self.view.height < kDeviceHeight - 64 - kAppAdaptWidth(44) - 10);
        float bgHeight = kAppAdaptHeight(300);
        if (hasTab) {
            bgHeight = kAppAdaptHeight(240);
        }
        _sortPickerBgView = [[JHView alloc] initWithFrame:CGRectMake(0, self.view.height - bgHeight, kDeviceWidth, bgHeight)];
        _sortPickerBgView.backgroundColor = kWhiteColor;
        [self.view addSubview:_sortPickerBgView];
        
        float pickY = kAppAdaptHeight(60);
        if (hasTab) {
            pickY = kAppAdaptHeight(40);
        }
        _sortPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, pickY, kDeviceWidth, kAppAdaptHeight(200))];
        _sortPickerView.backgroundColor = kRGB(244, 244, 244);
        _sortPickerView.delegate = self;
        _sortPickerView.dataSource = self;
        _sortPickerView.showsSelectionIndicator = YES;
        [_sortPickerView selectRow:_sortType inComponent:0 animated:NO];
        _sortPickerBgView.backgroundColor = _sortPickerView.backgroundColor;
        [_sortPickerBgView addSubview:_sortPickerView];
        
        NSString *titleString = kStr(@"Mine_Logout_Cancel");
        float width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
        JHButton *cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
        [cancelBtn setTitle:titleString forState:UIControlStateNormal];
        [cancelBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = kAppAdaptFont(16);
        [_sortPickerBgView addSubview:cancelBtn];
        
        titleString = kStr(@"Mine_Logout_Ok");
        width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
        JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - width - kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
        [confirmBtn setTitle:titleString forState:UIControlStateNormal];
        [confirmBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.titleLabel.font = kAppAdaptFont(16);
        [_sortPickerBgView addSubview:confirmBtn];
    }
}

- (void)touchCloseBtn:(JHButton *)sender {
    [UIView animateWithDuration:0.3 animations:^() {
        _sortPickerBgView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [_sortPickerBgView removeFromSuperview];
            _sortPickerBgView = nil;
        }
    }];
    [sender removeFromSuperview];
    sender = nil;
}

- (void)touchCancelBtn:(JHButton *)sender {
    [self removePickerView];
}

- (void)removePickerView {
    [_sortPickerBgView removeFromSuperview];
    _sortPickerBgView = nil;
    [_sortPickerView removeFromSuperview];
    _sortPickerView = nil;
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

- (void)touchConfirmBtn:(JHButton *)sender {
    NSInteger index = [_sortPickerView selectedRowInComponent:0];
    _sortType = index;
    [_sortView setItemSelected:NO title:_sortArray[index] index:0];
    [self removePickerView];
    //request data
    [self loadData:YES pulling:NO];
}

- (void)handleFilterApply:(WGClassifyFilterCondition *)filter {
    _filter = filter;
    [_sortView setItemSelected:[_filter hasSelected] index:1];
    //[self ]
    [self loadData:YES pulling:NO];
}

- (void)openGoodDetailViewController:(WGHomeFloorContentGoodItem *)item {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = item.id;
    vc.title = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAddShopCart:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint )fromPoint {
    if ([NSString isNullOrEmpty:[WGApplication sharedApplication].currentPostCode]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WGPostCodePopoverView *view = [[WGPostCodePopoverView alloc] initWithFrame:window.bounds];
        [view showInView:window];
        return;
    }
    WeakSelf;
    [[WGApplication sharedApplication] loadAddGoodToCart:item.id count:1 onCompletion:^(WGAddGoodToCartResponse *response) {
        [weakSelf handleShopCartCount:response];
    }];
    [[WGApplication sharedApplication] addShopToCart:item.pictureURL fromPoint:fromPoint];
}

- (void)handleShopCartCount:(WGAddGoodToCartResponse *)response {
    if (response.success) {
        [[WGApplication sharedApplication] handleShopCartGoodCount:response.data.goodCount];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)scrollToTop {
    [super scrollToTop];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGClassifyDetailContentViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2 + ((_data && _data.recommendedArray) ? _data.recommendedArray.count : 0);   //轮播+消息+推荐
    }
    else {
        return (_data && _data.goodArray) ? ((_isGrid) ? (_data.goodArray.count + 1) / 2 : _data.goodArray.count) : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return kAppAdaptHeight(44);
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger row = indexPath.row;
        if (row == 0) {
            return _data.hasCarousel ? kAppAdaptHeight(176) : 0;
        }
        else if (row == 1) {
            return _data.hasNews ? kAppAdaptHeight(44) : 0;
        }
        else {
            return [WGHomeFloorGoodListItemCell heightWithData:nil];
        }
    }
    else {
        return _isGrid ? [WGClassifyDetailGoodGridItemCell heightWithArray:nil] : [WGHomeFloorGoodListItemCell heightWithData:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        WeakSelf;
        if (!_sortView) {
            _sortView = [[WGClassifySortView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(44))];
            _sortView.backgroundColor = kWhiteColor;
            _sortView.onApply = ^(NSInteger index) {
                [weakSelf handleSortApply:index];
            };
            JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
            line.backgroundColor = WGAppSeparateLineColor;
            [_sortView addSubview:line];
        }
        return _sortView;
    }
    return nil;
}

- (NSString *)identifier:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    if (indexPath.section == 0) {
        identifier = [NSString stringWithFormat:@"cellId_%ld_%ld", indexPath.section, ((indexPath.row > 1) ? 2 : indexPath.row)];
    }
    else {
        identifier = [NSString stringWithFormat:@"cellId_%ld_%d", indexPath.section, _isGrid];
    }
    return identifier;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [self identifier:indexPath];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (!cell) {
        if (section == 0) {
            if (row == 0) {
                cell = [[WGHomeCarouselFiguresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (row == 1) {
                cell = [[WGHomeNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else {
                WeakSelf;
                WGHomeFloorGoodListItemCell *goodListCell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                goodListCell.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
                    [weakSelf handleAddShopCart:item fromPoint:fromPoint];
                };
                cell = goodListCell;
                JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
                line.backgroundColor = WGAppSeparateLineColor;
                [cell.contentView addSubview:line];
            }
        }
        else {
            if (_isGrid) {
                WeakSelf;
                WGClassifyDetailGoodGridItemCell *gridCell = [[WGClassifyDetailGoodGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                gridCell.onApply = ^(WGHomeFloorContentGoodItem *item) {
                    [weakSelf openGoodDetailViewController:item];
                };
                gridCell.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
                    [weakSelf handleAddShopCart:item fromPoint:fromPoint];
                };
                cell = gridCell;
            }
            else {
                WeakSelf;
                WGHomeFloorGoodListItemCell *goodListCell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                goodListCell.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
                    [weakSelf handleAddShopCart:item fromPoint:fromPoint];
                };
                cell = goodListCell;
                JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
                line.backgroundColor = WGAppSeparateLineColor;
                [cell.contentView addSubview:line];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (section == 0) {
        if (row == 0) {
            if (_data.hasCarousel) {
                [cell showWithArray:@[_data.carouselFigureItem.pictureURL]];
            }
        }
        else if (row == 1) {
            if (_data.hasNews) {
                [cell showWithData:_data.news];
            }
        }
        else {
            WGHomeFloorContentGoodItem *item = _data.recommendedArray[row - 2];
            [cell showWithData:item];
        }
    }
    else {
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
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger row = indexPath.row;
        if (row >= 2) {
            WGHomeFloorContentGoodItem *item = _data.recommendedArray[row - 2];
            [self openGoodDetailViewController:item];
        }
    }
    else {
        if (!_isGrid) {
            //打开详情
            WGHomeFloorContentGoodItem *item = _data.goodArray[indexPath.row];
            [self openGoodDetailViewController:item];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showTopButton:(scrollView.contentOffset.y > kAppAdaptHeight(176)) ? YES : NO];
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadData:YES pulling:YES];
    if (self.onTopRefresh) {
        self.onTopRefresh();
    }
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadData:NO pulling:YES];
}

@end

@implementation WGClassifyDetailContentViewController (PickerViewDelegate)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _sortArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kAppAdaptHeight(40);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _sortArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //[self loadData:YES pulling:NO];
}

@end
