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
    JHTableView *_tableView;
    BOOL _isGrid;
    JHButton *_vistaBtn;
}
@end

@interface WGSearchViewController (TextField)

@end

@interface WGSearchViewController (TableView) <UITableViewDelegate, UITableViewDataSource>

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

- (void)initData {
    _data = [[WGSearchData alloc] init];
    WGSearchKeywordItem *item = [[WGSearchKeywordItem alloc] init];
    item.id = 12;
    item.name = @"郑要要";
    
    WGSearchKeywordItem *item2 = [[WGSearchKeywordItem alloc] init];
    item2.id = 12;
    item2.name = @"郑s左厅要要";
    
    WGSearchKeywordItem *item3 = [[WGSearchKeywordItem alloc] init];
    item3.id = 12;
    item3.name = @"郑要";
    
    WGSearchKeywordItem *item4 = [[WGSearchKeywordItem alloc] init];
    item4.id = 12;
    item4.name = @"郑要要我们";
    
    WGSearchKeywordItem *item5 = [[WGSearchKeywordItem alloc] init];
    item5.id = 12;
    item5.name = @"我们";
    
    WGSearchKeywordItem *item6 = [[WGSearchKeywordItem alloc] init];
    item6.id = 12;
    item6.name = @"我们是中国";
    
    WGSearchKeywordItem *item7 = [[WGSearchKeywordItem alloc] init];
    item7.id = 12;
    item7.name = @"人";
    
    WGSearchKeywordItem *item8 = [[WGSearchKeywordItem alloc] init];
    item8.id = 12;
    item8.name = @"测试侃侃";
    
    _data.name = @"asdfasdfa";
    _data.keywords = @[item, item2, item3, item4, item5, item6, item7, item8, item8];
    
    WGSearchClassifyItem *classifyItem = [[WGSearchClassifyItem alloc] init];
    classifyItem.name = @"iiii";
    
    WGHomeFloorContentGoodItem *gooditem = [[WGHomeFloorContentGoodItem alloc] init];
    gooditem.name = @"fasdfasdfasdfasdf";
    gooditem.pictureURL = @"";
    gooditem.chineseName = @"郑渊谦";
    gooditem.briefDescription = @"asdfasdfasdfasdfasdfas";
    gooditem.price = @"932.32";
    gooditem.currentPrice = @"322.23";

    WGHomeFloorContentGoodItem *gooditem1 = [[WGHomeFloorContentGoodItem alloc] init];
    gooditem1.name = @"sadfas";
    gooditem1.pictureURL = @"";
    gooditem1.chineseName = @"郑渊谦";
    gooditem1.briefDescription = @"asdfasdfasdfasdfasdfas";
    gooditem1.price = @"932.32";
    gooditem1.currentPrice = @"322.23";

    WGHomeFloorContentGoodItem *gooditem2 = [[WGHomeFloorContentGoodItem alloc] init];
    gooditem2.name = @"zhengasdfl";
    gooditem2.pictureURL = @"";
    gooditem2.chineseName = @"郑渊谦";
    gooditem2.briefDescription = @"asdfasdfasdfasdfasdfas";
    gooditem2.price = @"932.32";
    gooditem2.currentPrice = @"122.23";
    classifyItem.goods = @[gooditem, gooditem1, gooditem2, gooditem2];
    
    
    WGSearchClassifyItem *classifyItem2 = [[WGSearchClassifyItem alloc] init];
    classifyItem2.name = @"00000";
    classifyItem2.goods = @[gooditem2, gooditem1, gooditem1, gooditem1];
    
    _data.classifys = @[classifyItem, classifyItem2];
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
    _textFiled.backgroundColor = kHRGBA(0xFFFFFF, 0.16);
    _textFiled.returnKeyType = UIReturnKeySearch;
    [_textFiled addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    _textFiled.layer.cornerRadius = 3;
    _textFiled.clearButtonMode = UITextFieldViewModeAlways;
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
    
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
    
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.layer.opacity = 0.0f;
    [contentView addSubview:_tableView];
    
    [self addHotSearchViewController:contentView];
    
    [self refreshUI];
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
    WGSearchGoodListViewController *vc = [[WGSearchGoodListViewController alloc] init];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGSearchViewController (TableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    if (_data) {
        count = 1;
        if (_data.classifys) {
            count += _data.classifys.count;
        }
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_data && _data.keywords) {
            return 1;
        }
        else {
            return 0;
        }
    }
    else {
        NSInteger index = section - 1;
        WGSearchClassifyItem *item = _data.classifys[index];
        return ((_isGrid) ? (item.goods.count + 1) / 2 : item.goods.count);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (_data) {
            if (_data.keywords && _data.keywords.count > 0) {
                return kAppAdaptHeight(40);
            }
            else {
                return 0.01f;
            }
        }
        else {
            return 0.01f;
        }
    }
    else {
        return kAppAdaptHeight(40);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [WGHotSearchCell heightWithArray:_data.keywords];
    }
    else {
        return _isGrid ? [WGHomeFloorGoodGridItemCell heightWithData:nil] : [WGHomeFloorGoodListItemCell heightWithData:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JHView *view = [[JHView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = kHRGB(0xF8FAFA);
    JHLabel *nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(40))];
    nameLabel.font = kAppAdaptFont(14);
    nameLabel.textColor = WGAppNameLabelColor;
    NSString *title = nil;
    if (0 == section) {
        title = _data.name;
    }
    else {
        WGSearchClassifyItem *item = _data.classifys[section - 1];
        title = item.name;
    }
    nameLabel.text = title;
    [view addSubview:nameLabel];
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _data.name;
    }
    else {
        WGSearchClassifyItem *item = _data.classifys[section - 1];
        return item.name;
    }
}

- (NSString *)identifier:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    if (indexPath.section == 0) {
        identifier = @"cellId_0_1";
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
    NSInteger section = indexPath.section;
    if (!cell) {
        if (section == 0) {
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
    if (section == 0) {
        [cell showWithArray:_data.keywords];
    }
    else {
        WGSearchClassifyItem *item = _data.classifys[section - 1];
        if (_isGrid) {
            NSInteger index = indexPath.row * 2;
            NSMutableArray *array = [NSMutableArray arrayWithObjects:item.goods[index], nil];
            if (index + 1 < item.goods.count) {
                [array addObject:item.goods[index + 1]];
            }
            [cell showWithArray:array];
        }
        else {
            JHView *line = [cell.contentView viewWithTag:999];
            if (line) {
                line.hidden = (indexPath.row == 0);
            }
            WGHomeFloorContentGoodItem *goodItem = item.goods[indexPath.row];
            [cell showWithData:goodItem];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        WGSearchClassifyItem *item = _data.classifys[indexPath.section - 1];
        WGHomeFloorContentGoodItem *good = item.goods[indexPath.row];
        [self openGoodDetailViewController:good.id];
    }
}

@end

@implementation WGSearchViewController (TextField)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
