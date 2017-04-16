//
//  WGBaseFootPrintAndCollectionViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseFootPrintAndCollectionViewController.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGGoodDetailViewController.h"
#import "WGViewController+ShopCart.h"

@interface WGBaseFootPrintAndCollectionViewController ()

@end

@interface WGBaseFootPrintAndCollectionViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGBaseFootPrintAndCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadListResponse:YES pulling:NO];
}

- (void)initData {
    _dataMArray = [[NSMutableArray alloc] init];
//    WGHomeFloorContentGoodItem *item = [[WGHomeFloorContentGoodItem alloc] init];
//    item.name = @"fasdfasdfasdfasdf";
//    item.pictureURL = @"";
//    item.chineseName = @"郑渊谦";
//    item.briefDescription = @"asdfasdfasdfasdfasdfas";
//    item.price = @"932.32";
//    item.currentPrice = @"322.23";
//    
//    WGHomeFloorContentGoodItem *item1 = [[WGHomeFloorContentGoodItem alloc] init];
//    item1.name = @"sadfas";
//    item1.pictureURL = @"";
//    item1.chineseName = @"郑渊谦";
//    item1.briefDescription = @"asdfasdfasdfasdfasdfas";
//    item1.price = @"932.32";
//    item1.currentPrice = @"322.23";
//    
//    WGHomeFloorContentGoodItem *item2 = [[WGHomeFloorContentGoodItem alloc] init];
//    item2.name = @"zhengasdfl";
//    item2.pictureURL = @"";
//    item2.chineseName = @"郑渊谦";
//    item2.briefDescription = @"asdfasdfasdfasdfasdfas";
//    item2.price = @"932.32";
//    item2.currentPrice = @"122.23";
//    
//    _dataMArray = [NSMutableArray arrayWithArray:@[item, item1, item2]];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    [self initNavigationItem];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop | TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    //_tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    _tableView.layer.opacity = 0.0f;
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

- (void)handleAddShopCart:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint )fromPoint {
    [[WGApplication sharedApplication] loadAddGoodToCart:item.id count:1 onCompletion:^(WGAddGoodToCartResponse *response) {
        [WGApplication sharedApplication].shopCartGoodCount = response.data.goodCount;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUpdateShopCartCount object:nil];
    }];
    [[WGApplication sharedApplication] addShopToCart:item.pictureURL fromPoint:fromPoint];
}

- (void)handleDeleteIndexPath:(NSIndexPath *)indexPath {

}

- (void)loadListResponse:(BOOL)refresh pulling:(BOOL)pulling {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGBaseFootPrintAndCollectionViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataMArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(124);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WGHomeFloorGoodListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    WeakSelf;
    if (!cell) {
        cell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
            [weakSelf handleAddShopCart:item fromPoint:fromPoint];
        };
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
    }
    [cell showWithData:_dataMArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WGHomeFloorContentGoodItem *item = _dataMArray[indexPath.row];
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = item.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self handleDeleteIndexPath:indexPath];
    }
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadListResponse:YES pulling:YES];
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadListResponse:NO pulling:YES];
}

@end
