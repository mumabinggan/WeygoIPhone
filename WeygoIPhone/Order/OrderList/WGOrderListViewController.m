//
//  WGOrderListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListViewController.h"
#import "WGOrderListGoodsCell.h"
#import "WGOrderListPriceCell.h"
#import "WGOrderListRebuyCell.h"
#import "WGOrderListViewController+Request.h"
#import "WGOrderDetailViewController.h"
#import "WGGoodDetailViewController.h"
#import "WGViewController+ShopCart.h"

@interface WGOrderListViewController ()

@end

@interface WGOrderListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadOrderList:YES pulling:NO];
}

- (void)initSubView {
    [super initSubView];
    
    [self initNavigationItem];
    
    self.title = kStr(@"Order List Title");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop | TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
}

- (void)refreshUI {
    [_tableView reloadData];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

- (void)handleReBuy:(WGOrderListItem *)item fromPoint:(CGPoint)fromPoint {
    WeakSelf;
    [self showLoadingViewWithMessage:nil];
    [[WGApplication sharedApplication] loadRebuyOrder:item.id onCompletion:^(WGRebuyOrderResponse *response) {
        [weakSelf handleRebuy:response fromPoint:fromPoint];
    }];
}

- (void)handleRebuy:(WGRebuyOrderResponse *)response fromPoint:(CGPoint)fromPoint {
    [self removeLoadingView];
    [self showWarningMessage:response.message];
    [[WGApplication sharedApplication] addShopToCartImage:@"add_cart" fromPoint:fromPoint];
}

- (void)handleGoodDetail:(long long)goodId {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGOrderListViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderMArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_orderMArray.count == section + 1) {
        return kAppAdaptHeight(0.5);
    }
    return kAppAdaptHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    NSInteger row = indexPath.row;
    if (row == 0) {
        height = kAppAdaptHeight(40);
    }
    else if (row == 1) {
        height = kAppAdaptHeight(232);
    }
    else if (row == 2) {
        height = kAppAdaptHeight(48);
    }
    else {
        height = kAppAdaptHeight(56);
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    cellId = [NSString stringWithFormat:@"cellId_%ld", row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (0 == row) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.textLabel.font = kAppAdaptFont(14);
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.contentView.backgroundColor = kHRGB(0xF8FAFA);
            cell.detailTextLabel.font = cell.textLabel.font;
            cell.detailTextLabel.textColor = WGAppLightNameLabelColor;
        }
        else if (row == 1) {
            __weak id weakSelf = self;
            WGOrderListGoodsCell *goodsCell = [[WGOrderListGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            goodsCell.onApply = ^(WGOrderGoodItem *item) {
                [weakSelf handleGoodDetail:item.id];
            };
            cell = goodsCell;
        }
        else if (row == 2) {
            cell = [[WGOrderListPriceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 3) {
            __weak id weakSelf = self;
            WGOrderListRebuyCell *reBuyCell = [[WGOrderListRebuyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            reBuyCell.onApply = ^(WGOrderListItem *item, CGPoint fromPoint) {
                [weakSelf handleReBuy:item fromPoint:fromPoint];
            };
            cell = reBuyCell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WGOrderListItem *item = _orderMArray[section];
    if (row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:kStr(@"Order Number"), item.sn];
        cell.detailTextLabel.text = item.status;
    }
    else {
        [cell showWithData:item];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        WGOrderListItem *item = _orderMArray[indexPath.section];
        WGOrderDetailViewController *vc = [[WGOrderDetailViewController alloc] init];
        vc.orderId = item.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadOrderList:YES pulling:YES];
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadOrderList:NO pulling:YES];
}

@end
