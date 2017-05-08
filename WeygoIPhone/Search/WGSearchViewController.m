//
//  WGSearchViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSearchViewController.h"
#import "WGSearchViewController+Request.h"
#import "WGHotSearchViewController.h"
#import "WGHotSearchCell.h"
#import "WGHotSearchHistoryCell.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGGoodDetailViewController.h"
#import "WGSearchGoodListViewController.h"
#import "WGSearchKeywordItem.h"
#import "WGHomeFloorGoodGridItemCell.h"
#import "WGShopCartGoodItem.h"
#import "WGHomeFloorContentItem.h"
#import "WGViewController+ShopCart.h"

@interface WGSearchViewController ()
{
    BOOL _isGrid;
    JHButton *_vistaBtn;
}
@end

@interface WGSearchViewController (TextField)<UITextFieldDelegate>

@end

@interface WGSearchViewController (TableView) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_hotSearchViewController refreshHistory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self loadSearch];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:contentView];
    
    JHView *titleView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth - 56 * 2, kAppNavigationBarHeight)];
    CGRect frame = CGRectMake(0, kAppAdaptHeight(8), titleView.width, kAppAdaptHeight(28));
    _textFiled = [[JHTextField alloc] initWithFrame:frame];
    _textFiled.font = kAppFont(13);
    _textFiled.textColor = kWhiteColor;
    _textFiled.tintColor = kWhiteColor;
    _textFiled.delegate = self;
    _textFiled.backgroundColor = kHRGBA(0xFFFFFF, 0.16);
    _textFiled.returnKeyType = UIReturnKeySearch;
    [_textFiled addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    _textFiled.layer.cornerRadius = 3;
    _textFiled.clearButtonMode = UITextFieldViewModeAlways;
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
    _textFiled.text = _name;
    
    JHView *leftView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(20) + 15, _textFiled.height)];
    JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    imageView.center = CGPointMake(leftView.width/2, leftView.height/2);
    imageView.image = [UIImage imageNamed:@"right_search"];
    [leftView addSubview:imageView];
    _textFiled.leftView = leftView;
    
    _vistaBtn = [self createVistaButton];
    _vistaBtn.x = titleView.width - 18;
    _vistaBtn.layer.opacity = 0.0f;
    [titleView addSubview:_vistaBtn];
    
    [titleView addSubview:_textFiled];
    
    self.navigationItem.titleView = titleView;
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop | TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.layer.opacity = 0.0f;
    [contentView addSubview:_tableView];
    
    [self addHotSearchViewController:contentView];
    [self textFieldEditChanged:_textFiled];
    
    if (![NSString isNullOrEmpty:_name]) {
        _currentSearchString = _name;
        [self loadSearch:YES pulling:NO];
    }
}

- (JHButton *)createVistaButton {
    JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"vista_normal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"vista_selected"] forState:UIControlStateSelected];
    [backButton setTitle:nil forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchVistaButton:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
    [backButton sizeToFit];
    CGRect r = backButton.frame;
    r.size.height = 44;
    r.size.width += 3;
    backButton.frame = r;
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return backButton;
}

- (void)touchVistaButton:(JHButton *)button {
    button.selected = !button.selected;
    _isGrid = button.selected;
    [_tableView reloadData];
}

- (void)addHotSearchViewController:(JHView *)contentView {
    if (!_hotSearchViewController) {
        _hotSearchViewController = [[WGHotSearchViewController alloc] init];
        [contentView addSubview:_hotSearchViewController.view];
        [self addChildViewController:_hotSearchViewController];
    }
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)handleOnApplyKeyword:(WGSearchKeywordItem *)item {
    WGSearchViewController *vc = [[WGSearchViewController alloc] init];
    vc.name = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textFieldEditChanged:(UITextField *)textField {
    NSString *text = textField.text;
    if ([NSString isNullOrEmpty:text]) {
        [_hotSearchViewController refreshHistory];
        _hotSearchViewController.view.hidden = NO;
        _data = nil;
        [self refreshUI];
        [UIView animateWithDuration:0.20 animations:^() {
            _textFiled.width = kDeviceWidth - 56 * 2;
            _vistaBtn.layer.opacity = 0.0f;
        }];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else {
        _hotSearchViewController.view.hidden = YES;
        [UIView animateWithDuration:0.20 animations:^() {
            _textFiled.width = kDeviceWidth - 56 * 2 - 30;
            _vistaBtn.layer.opacity = 1.0f;
        }];
        self.navigationItem.rightBarButtonItem = [self createShopCartItem];
        //[self loadSearch];
    }
}

- (void)openGoodDetailViewController:(long long)goodId {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAddShopCart:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint )fromPoint {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGSearchViewController (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (_data) {
        count = 2;
        if (_isGrid) {
            if (_data && _data.goods && _data.goods.count > 0) {
                count = 2 + (_data.goods.count+1)/2;
            }
            else {
                count = 2;
            }
        }
        else {
            count = 2 + ((_data.goods) ? _data.goods.count : 0);
        }
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    NSInteger row = indexPath.row;
    if (row == 0) {
        if (_data && _data.keywords && _data.keywords.count > 0) {
            height = kAppAdaptHeight(40);
        }
    }
    else if (row == 1) {
        height = [WGHotSearchCell heightWithArray:_data.keywords];
    }
    else {
        height = _isGrid ? [WGHomeFloorGoodGridItemCell heightWithData:nil] : [WGHomeFloorGoodListItemCell heightWithData:nil];
    }
    return height;
}

- (NSString *)identifier:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    NSInteger row = indexPath.row;
    if (row == 0) {
        identifier = @"cellId_0_1";
    }
    else if (row == 1) {
        identifier = @"cellId_1_1";
    }
    else {
        identifier = [NSString stringWithFormat:@"cellId_good_%d", _isGrid];
    }
    return identifier;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [self identifier:indexPath];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSInteger row = indexPath.row;
    if (!cell) {
        if (row == 0) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColor = kHRGB(0xF8FAFA);
            cell.textLabel.font = kAppAdaptFont(14);
            cell.textLabel.textColor = WGAppNameLabelColor;
        }
        else if (row == 1) {
            WeakSelf;
            WGHotSearchCell *hotCell = [[WGHotSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            hotCell.onApply = ^(WGSearchKeywordItem *item) {
                [weakSelf handleOnApplyKeyword:item];
            };
            cell = hotCell;
        }
        else {
            if (_isGrid) {
                WeakSelf;
                WGHomeFloorGoodGridItemCell *gridCell = [[WGHomeFloorGoodGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                gridCell.onApply = ^(WGHomeFloorContentItem *item) {
                    [weakSelf openGoodDetailViewController:item.id];
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
                line.tag = 999;
                line.backgroundColor = WGAppSeparateLineColor;
                [cell.contentView addSubview:line];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:kStr(@"Search_Keyword"), _currentSearchString];
    }
    else if (row == 1) {
        [cell showWithArray:_data.keywords];
    }
    else {
        if (_isGrid) {
            NSArray *goods = _data.goods;
            NSInteger index = (indexPath.row - 2) * 2;
            NSMutableArray *array = [NSMutableArray arrayWithObjects:goods[index], nil];
            if (index + 1 < goods.count) {
                [array addObject:goods[index + 1]];
            }
            [cell showWithArray:array];
        }
        else {
            JHView *line = [cell.contentView viewWithTag:999];
            if (line) {
                line.hidden = (indexPath.row == 0);
            }
            WGHomeFloorContentGoodItem *item = _data.goods[row - 2];
            [cell showWithData:item];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 1 && !_isGrid) {
        WGHomeFloorContentGoodItem *item = _data.goods[indexPath.row - 2];
        [self openGoodDetailViewController:item.id];
    }
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadSearch:NO pulling:YES];
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadSearch:YES pulling:YES];
}

@end

@implementation WGSearchViewController (TextField)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _currentSearchString = textField.text;
    [textField resignFirstResponder];
    [self loadSearch:YES pulling:NO];
    return YES;
}

@end
