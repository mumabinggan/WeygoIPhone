//
//  WGOrderDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderDetailViewController.h"
#import "WGOrderStatusCell.h"
#import "WGOrderDeliverCell.h"
#import "WGOrderGoodPriceCell.h"
#import "WGOrderLookAllGoodCell.h"
#import "WGOrderFaxCell.h"
#import "WGOrderPayCell.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGOrderGoodItem.h"
#import "WGOrderDetailViewController+Request.h"
#import "WGViewController+ShopCart.h"
#import "WGViewController+TopButton.h"

@interface WGOrderDetailViewController ()
{
    BOOL _showAllGoods;
    JHButton *_rebuyBtn;
}
@end

@interface WGOrderDetailViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadOrderDetail];
}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"Order Detail");
    
    [self initNavigationItem];
    
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    //[self initNavigationItem];
    CGFloat bottomHeight = kAppAdaptHeight(72);
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomHeight, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    
    JHView *bottomView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - bottomHeight, kDeviceWidth, bottomHeight)];
    bottomView.backgroundColor = kWhiteColor;
    [contentView addSubview:bottomView];
    
    _rebuyBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
    [_rebuyBtn addTarget:self action:@selector(touchReBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_rebuyBtn setTitle:kStr(@"Order Rebuy") forState:UIControlStateNormal];
    [_rebuyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _rebuyBtn.titleLabel.font = kAppAdaptFont(14);
    [bottomView addSubview:_rebuyBtn];
}

- (void)touchReBuyBtn:(JHButton *)sender {
    WeakSelf;
    [self showLoadingViewWithMessage:nil];
    [[WGApplication sharedApplication] loadRebuyOrder:_orderId onCompletion:^(WGRebuyOrderResponse *response) {
        [weakSelf handleRebuy:response];
    }];
}

- (void)handleRebuy:(WGRebuyOrderResponse *)response {
    [self removeLoadingView];
    [[WGApplication sharedApplication] handleShopCartGoodCount:response.data.goodCount];
    //[self showWarningMessage:response.message];
    [[WGApplication sharedApplication] addShopToCartImage:@"add_cart" fromPoint:CGPointMake(kDeviceWidth/2, kDeviceHeight - kAppAdaptHeight(72))];
}

- (void)showhowAllGoods {
    _showAllGoods = YES;
    [_tableView reloadData];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

- (void)refreshUI {
    [_tableView reloadData];
}

- (void)scrollToTop {
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfGoodsRow {
    NSInteger number;
    NSInteger count = _orderDetail.goods.count;
    if (_showAllGoods) {
        number = count + 2;
    }
    else {
        if (count > 3) {
            number = 3 + 2;
        }
        else {
            number = count + 2;
        }
    }
    return number;
}

@end

@implementation WGOrderDetailViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_orderDetail) ? 5 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if (2 == section) {
        number = [self numberOfGoodsRow];
    }
    else {
        number = 2;
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return kAppAdaptHeight(0.5f);
    }
    return kAppAdaptHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            height = kAppAdaptHeight(40);
        }
        else {
            height = [WGOrderStatusCell heightWithData:nil];
        }
    }
    else if (section == 1) {
        if (row == 0) {
            height = kAppAdaptHeight(40);
        }
        else {
            height = [WGOrderDeliverCell heightWithData:nil];
        }
    }
    else if (section == 2) {
        if (row == 0) {
            height = kAppAdaptHeight(40);
        }
        else {
            NSInteger count = [self numberOfGoodsRow];
            if (count == indexPath.row + 1) {
                NSInteger count = _orderDetail.goods.count;
                if (_showAllGoods) {
                    height = 0.0f;
                }
                else {
                    if (count > 3) {
                        height = kAppAdaptHeight(40);
                    }
                    else {
                        height = 0.0f;
                    }
                }
            }
            else {
                height = [WGOrderGoodPriceCell heightWithData:nil];
            }
        }
    }
    else if (section == 3) {
        if (row == 0) {
            height = kAppAdaptHeight(40);
        }
        else {
            height = [WGOrderFaxCell heightWithData:nil];
        }
    }
    else if (section == 4) {
        if (row == 0) {
            height = kAppAdaptHeight(40);
        }
        else {
            height = [WGOrderPayCell heightWithArray:_orderDetail.pay];
        }
    }
    return height;
}

- (NSString *)getIdentifier:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return @"headerCell";
    }
    else {
        if (indexPath.section == 2) {
            NSInteger count = [self numberOfGoodsRow];
            if (indexPath.row < count - 1) {
                return @"goodList";
            }
            else {
                return @"goodMoreCell";
            }
        }
        else {
            return [NSString stringWithFormat:@"cell_%ld_%ld", indexPath.section, indexPath.row];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [self getIdentifier:indexPath];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (!cell) {
        if (0 == row) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.font = kAppAdaptFont(14);
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.contentView.backgroundColor = kHRGB(0xF8FAFA);
        }
        else {
            if (section == 0) {
                cell = [[WGOrderStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (section == 1) {
                cell = [[WGOrderDeliverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (section == 2) {
                NSInteger count = [self numberOfGoodsRow];
                if (row < count - 1) {
                    cell = [[WGOrderGoodPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else {
                    __weak id weakSelf = self;
                    WGOrderLookAllGoodCell *moreCell = [[WGOrderLookAllGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    moreCell.onApply = ^() {
                        [weakSelf showhowAllGoods];
                    };
                    cell = moreCell;
                }
            }
            else if (section == 3) {
                cell = [[WGOrderFaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (section == 4) {
                cell = [[WGOrderPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.clipsToBounds = YES;
        cell.clipsToBounds = YES;
    }
    if (row == 0) {
        if (section == 0) {
            cell.textLabel.text = [NSString stringWithFormat:kStr(@"Order Number"), _orderDetail.sn];
        }
        else if (section == 1) {
            cell.textLabel.text = kStr(@"Order Deliver Goods Info");
        }
        else if (section == 2) {
            cell.textLabel.text = kStr(@"Order Goods List");
        }
        else if (section == 3) {
            cell.textLabel.text = kStr(@"Order Fattura");
        }
        else if (section == 4) {
            cell.textLabel.text = kStr(@"Order Pay Detail");
        }
    }
    else {
        if (section == 2) {
            NSArray *goods = _orderDetail.goods;
            if (goods.count > row - 1) {
                WGOrderGoodItem *item = goods[row - 1];
                [cell showWithData:item];
            }
        }
        else if (section == 4) {
            [cell showWithArray:_orderDetail.pay];
        }
        else {
            [cell showWithData:_orderDetail];
        }
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    JHButton *topButton = [self createTopButton];
    topButton.y = self.view.height - kAppAdaptWidth(140);
    [self showTopButton:(scrollView.contentOffset.y > kAppAdaptHeight(176)) ? YES : NO];
}

@end
