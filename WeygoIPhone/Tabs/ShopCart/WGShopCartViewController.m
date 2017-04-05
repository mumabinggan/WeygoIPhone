//
//  WGShopCartViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartViewController.h"
#import "WGShopCart.h"
#import "WGShopCartGoodItem.h"
#import "WGShopCartCell.h"
#import "WGShopCartViewController+Request.h"
#import "WGCommitOrderViewController.h"
#import "WGDeliverPriceView.h"

@interface WGShopCartViewController ()
{
    UIVisualEffectView *_footView;
    JHLabel *_deliveryPriceLabel;
    JHLabel *_totalePriceLabel;
}
@end

@interface WGShopCartViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Carrello");
    [self loadShopCartList:YES pulling:NO];
}

- (void)initData {
    _data = [[WGShopCart alloc] init];
    
    WGShopCartPrice *price = [[WGShopCartPrice alloc] init];
    price.deliveryPrice = @"99.00";
    price.totalePrice = @"8999.99";
    _data.shopCartPrice = price;
    
    WGShopCartGoodItem *goodItem = [[WGShopCartGoodItem alloc] init];
    goodItem.name = @"香蕉";
    goodItem.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem.price = @"9844.99";
    goodItem.reducePrice = @"244.99";
    goodItem.price = @"8939.99";
    
    WGShopCartGoodItem *goodItem2 = [[WGShopCartGoodItem alloc] init];
    goodItem2.name = @"苹果";
    goodItem2.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem2.price = @"1844.99";
    goodItem2.reducePrice = @"544.99";
    goodItem2.price = @"6939.99";
    
    WGShopCartGoodItem *goodItem3 = [[WGShopCartGoodItem alloc] init];
    goodItem3.name = @"梨";
    goodItem3.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem3.price = @"1844.99";
    goodItem3.reducePrice = @"544.99";
    goodItem3.price = @"6939.99";
    
    WGShopCartGoodItem *goodItem4 = [[WGShopCartGoodItem alloc] init];
    goodItem4.name = @"桔子";
    goodItem4.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem4.price = @"1844.99";
    goodItem4.reducePrice = @"544.99";
    goodItem4.price = @"6939.99";
    
    WGShopCartGoodItem *goodItem5 = [[WGShopCartGoodItem alloc] init];
    goodItem5.name = @"西瓜";
    goodItem5.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem5.price = @"1844.99";
    goodItem5.reducePrice = @"544.99";
    goodItem5.price = @"6939.99";
    
    _data.goods = @[goodItem, goodItem2, goodItem3, goodItem4, goodItem5];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height - kAppAdaptHeight(108)) style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:_tableView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _footView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _footView.frame = CGRectMake(0, self.view.height - kAppAdaptHeight(108), kDeviceWidth, kAppAdaptHeight(108));
    _footView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [contentView addSubview:_footView];
    _footView.hidden = YES;
    
    JHImageView *deliveryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(20), kAppAdaptWidth(20), kAppAdaptHeight(14))];
    deliveryImageView.image = [UIImage imageNamed:@"deliver_car"];
    [_footView addSubview:deliveryImageView];
    
    _deliveryPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_deliveryPriceLabel.maxY + kAppAdaptWidth(5), kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16 + 20 + 5), kAppAdaptHeight(20))];
    _deliveryPriceLabel.font = kAppAdaptFont(14);
    _deliveryPriceLabel.textColor = WGAppTitleColor;
    [_footView addSubview:_deliveryPriceLabel];
    
    _totalePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16), kAppAdaptHeight(20))];
    _totalePriceLabel.font = kAppAdaptFont(14);
    _totalePriceLabel.textColor = WGAppBaseColor;
    _totalePriceLabel.textAlignment = NSTextAlignmentRight;
    [_footView addSubview:_totalePriceLabel];
    
    JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [confirmBtn setTitle:kStr(@"Confirm") forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kAppAdaptFont(14);
    [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(touchConfirmBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:confirmBtn];
    //[self refreshTableView];
}

- (void)touchConfirmBtnBtn:(UIButton *)sender {
    WGDeliverPriceView *view = [[WGDeliverPriceView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    view.tip = _data.deliverPriceDescription;
    WeakSelf;
    view.onApply = ^(NSInteger index) {
        [weakSelf handleClose];
    };
    [view showInView:self.view];
}

- (void)handleClose {
    if ([WGApplication sharedApplication].isLogined) {
        //1, 判断有没有失效产品(服务端)， 如果有失效产品，提示删除
    }
    else {
        _loginType = WGLoginTypeShopCart;
        [self openCartLoginViewController];
    }
}

- (void)handleLoginSuccess:(id)customData {
    [super handleLoginSuccess:customData];
    if (_loginType == WGLoginTypeShopCart) {
        _loginType = WGLoginTypeNormal;
        [self loadShopCartList:YES pulling:YES];
    }
}

- (void)refreshUI {
    [self refreshTableView];
    _footView.hidden = !(_data && _data.goods && _data.goods.count);
    NSString *deliveryPrice = _data.shopCartPrice.deliveryPrice;
    _deliveryPriceLabel.text = deliveryPrice;
    NSString *totalePrice = _data.shopCartPrice.totalePrice;
    _totalePriceLabel.text = totalePrice;
}

- (void)refreshTableView {
    [_tableView reloadData];
}

- (void)didReceiveNotification:(NSInteger)notification {
    if (notification == WGRefreshNotificationTypeLogin) {
        [self loadShopCartList:YES pulling:NO];
    }
    else if (notification == WGRefreshNotificationTypeLogout) {
        //[self loadShopCart];
    }
}

- (void)handleUpdateGood:(WGShopCartGoodItem *)item {
    
}

- (void)intoCommitOrderViewController {
    WGCommitOrderViewController *vc = [[WGCommitOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGShopCartViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_data && _data.goods) ? _data.goods.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(124);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WGShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WGShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.onApply = ^(WGShopCartGoodItem *item) {
        
        };
    }
    [cell showWithData:_data.goods[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self loadDeleteIndexPath:indexPath];
    }
}

@end
