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

@interface WGOrderDetailViewController ()
{
    BOOL _showAllGoods;
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
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
    [addBtn addTarget:self action:@selector(touchReBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:kStr(@"Order Rebuy") forState:UIControlStateNormal];
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [bottomView addSubview:addBtn];
}

- (void)touchReBuyBtn:(JHButton *)sender {
    //跳转到购物车
    [[WGApplication sharedApplication] loadRebuyOrder:_orderId onCompletion:^(WGRebuyOrderResponse *response) {
        [[WGApplication sharedApplication] switchTab:WGTabIndexShopCart];
    }];
}
//
//- (void)initData {
//    _orderDetail = [[WGOrderDetail alloc] init];
//    WGOrderStatus *status = [[WGOrderStatus alloc] init];
//    status.currentStatus = 1;
//    WGOrderStatusItem *statusItem = [[WGOrderStatusItem alloc] init];
//    statusItem.time = @"1234.2323";
//    statusItem.statusText = @"asdf";
//    
//    WGOrderStatusItem *statusItem1 = [[WGOrderStatusItem alloc] init];
//    statusItem1.time = @"4.2323";
//    statusItem1.statusText = @"Faffsdf";
//    
//    WGOrderStatusItem *statusItem2 = [[WGOrderStatusItem alloc] init];
//    statusItem2.time = @"F1234.2323";
//    statusItem2.statusText = @"Wasdf";
//    
//    status.statusArray = @[statusItem, statusItem1, statusItem2];
//    _orderDetail.status = status;
//    
//    WGOrderDeliver *deliver = [[WGOrderDeliver alloc] init];
//    deliver.deliverTime = @"12122121";
//    deliver.userAddress = @"asdfasd";
//    deliver.userName = @"asdfasd";
//    deliver.phone = @"asdfasd";
//    deliver.totalPrice = @"3243.232";
//    _orderDetail.deliver = deliver;
//    
//    WGOrderGoodItem *goodItem = [[WGOrderGoodItem alloc] init];
//    goodItem.goodCount = 12;
//    goodItem.orderPrice = @"123.32";
//    goodItem.orderCurrentPrice = @"54.23";
//    goodItem.orderReducePrice = @"43.23";
//    goodItem.name = @"fasdfasdfasdfasdf";
//    goodItem.pictureURL = @"";
//    goodItem.chineseName = @"郑渊谦";
//    goodItem.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem.price = @"932.32";
//    goodItem.currentPrice = @"322.23";
//    
//    WGOrderGoodItem *goodItem1 = [[WGOrderGoodItem alloc] init];
//    goodItem1.goodCount = 1;
//    goodItem1.orderPrice = @"123.32";
//    goodItem1.orderCurrentPrice = @"54.23";
//    goodItem1.orderReducePrice = @"43.23";
//    goodItem1.name = @"sadfas";
//    goodItem1.pictureURL = @"";
//    goodItem1.chineseName = @"郑渊谦";
//    goodItem1.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem1.price = @"932.32";
//    goodItem1.currentPrice = @"322.23";
//    
//    WGOrderGoodItem *goodItem2 = [[WGOrderGoodItem alloc] init];
//    goodItem1.goodCount = 4;
//    goodItem2.orderPrice = @"123.32";
//    goodItem2.orderCurrentPrice = @"54.23";
//    goodItem2.orderReducePrice = @"43.23";
//    goodItem2.name = @"zhengasdfl";
//    goodItem2.pictureURL = @"";
//    goodItem2.chineseName = @"郑渊谦";
//    goodItem2.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem2.price = @"932.32";
//    goodItem2.currentPrice = @"122.23";
//    
//    _orderDetail.goods = @[goodItem, goodItem1, goodItem2];
//    
//    WGOrderFax *fax = [[WGOrderFax alloc] init];
//    fax.taxCode = @"asdfasd";
//    fax.cap = @"3434343";
//    fax.companyName = @"fdsaasdfasdfsdaf";
//    _orderDetail.fax = fax;
//    
//    WGOrderPay *pay = [[WGOrderPay alloc] init];
//    pay.totalPrice = @"3223.12";
//    pay.currentPrice = @"3434.32";
//    pay.reducePrice = @"23.3";
//    _orderDetail.pay = pay;
//}

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

@end
