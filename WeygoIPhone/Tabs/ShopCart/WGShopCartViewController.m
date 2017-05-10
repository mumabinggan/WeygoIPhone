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
#import "WGGoodDetailViewController.h"

@interface WGShopCartViewController ()
{
    UIVisualEffectView *_footView;
    JHLabel *_deliveryPriceLabel;
    JHLabel *_totalePriceLabel;
}
@end

@interface WGShopCartViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGShopCartViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadShopCartList:YES pulling:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Carrello");
}

//- (void)initData {
//    _data = [[WGShopCart alloc] init];
//    
//    WGShopCartPrice *price = [[WGShopCartPrice alloc] init];
//    price.deliveryPrice = @"99.00";
//    price.totalePrice = @"8999.99";
//    _data.shopCartPrice = price;
//    
//    WGShopCartGoodItem *goodItem = [[WGShopCartGoodItem alloc] init];
//    goodItem.name = @"香蕉";
//    goodItem.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
//    goodItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    goodItem.price = @"9844.99";
//    goodItem.reducePrice = @"244.99";
//    goodItem.price = @"8939.99";
//    
//    WGShopCartGoodItem *goodItem2 = [[WGShopCartGoodItem alloc] init];
//    goodItem2.name = @"苹果";
//    goodItem2.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
//    goodItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    goodItem2.price = @"1844.99";
//    goodItem2.reducePrice = @"544.99";
//    goodItem2.price = @"6939.99";
//    
//    WGShopCartGoodItem *goodItem3 = [[WGShopCartGoodItem alloc] init];
//    goodItem3.name = @"梨";
//    goodItem3.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
//    goodItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    goodItem3.price = @"1844.99";
//    goodItem3.reducePrice = @"544.99";
//    goodItem3.price = @"6939.99";
//    
//    WGShopCartGoodItem *goodItem4 = [[WGShopCartGoodItem alloc] init];
//    goodItem4.name = @"桔子";
//    goodItem4.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
//    goodItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    goodItem4.price = @"1844.99";
//    goodItem4.reducePrice = @"544.99";
//    goodItem4.price = @"6939.99";
//    
//    WGShopCartGoodItem *goodItem5 = [[WGShopCartGoodItem alloc] init];
//    goodItem5.name = @"西瓜";
//    goodItem5.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
//    goodItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
//    goodItem5.price = @"1844.99";
//    goodItem5.reducePrice = @"544.99";
//    goodItem5.price = @"6939.99";
//    
//    _data.goods = @[goodItem, goodItem2, goodItem3, goodItem4, goodItem5];
//}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    
    _tableView = [[JHTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height - kAppAdaptHeight(108)) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = kWhiteColor;
    [contentView addSubview:_tableView];
    _tableView.layer.opacity = 0.0f;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _footView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _footView.frame = CGRectMake(0, self.view.height - kAppAdaptHeight(108), kDeviceWidth, kAppAdaptHeight(108));
    _footView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [contentView addSubview:_footView];
    _footView.hidden = YES;
    
    JHImageView *deleteImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(20), kAppAdaptWidth(20), kAppAdaptHeight(14))];
    deleteImageView.image = [UIImage imageNamed:@"shopcart_clean"];
    [_footView addSubview:deleteImageView];
    deleteImageView.userInteractionEnabled = YES;
    _footView.layer.opacity = 0.0f;
    
    [deleteImageView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchCleanShopCart:)];
    
    JHLabel *deleteLabel = [[JHLabel alloc] initWithFrame:CGRectMake(deleteImageView.maxX + kAppAdaptWidth(5), kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16 + 20 + 5), kAppAdaptHeight(20))];
    deleteLabel.font = kAppAdaptFont(14);
    deleteLabel.text = kStr(@"ShopCart_Clean");
    deleteLabel.textColor = WGAppTitleColor;
    deleteLabel.userInteractionEnabled = YES;
    [_footView addSubview:deleteLabel];
    [deleteLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(touchCleanShopCart:)];
    
    JHImageView *deliveryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 - kAppAdaptWidth(22), kAppAdaptHeight(20), kAppAdaptWidth(20), kAppAdaptHeight(14))];
    deliveryImageView.image = [UIImage imageNamed:@"deliver_car"];
    [_footView addSubview:deliveryImageView];
    _footView.layer.opacity = 0.0f;
    
    _deliveryPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(deliveryImageView.maxX + kAppAdaptWidth(5), kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16 + 20 + 5), kAppAdaptHeight(20))];
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
    if ([WGApplication sharedApplication].isLogined) {
        //1, 判断有没有失效产品(服务端)， 如果有失效产品，提示删除
        [self loadCheckFailureGood];
    }
    else {
        _loginType = WGLoginTypeShopCart;
        [self openCartLoginViewController];
    }
}

- (void)touchCleanShopCart:(UIGestureRecognizer *)regognizer {
    WeakSelf;
    [self showConfirmMessage:kStr(@"ShopCart_Clean_Tip") withTitle:nil cancelButtonTitle:kStr(@"Mine_Logout_Cancel") okButtonTitle:kStr(@"Mine_Logout_Ok") onCompletion:^(NSInteger index, UIAlertController *alertController) {
        if (1 == index) {
            [weakSelf handleCleanShopCart];
        }
    }];
}

- (void)handleCleanShopCart {
    [self loadCleanShopCart];
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
    _totalePriceLabel.text = [NSString stringWithFormat:kStr(@"Totale:Price With String Unit"), totalePrice];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
        _footView.layer.opacity = 1.0f;
    }];
}

- (void)refreshTableView {
    [_tableView reloadData];
}

- (void)didReceiveNotification:(NSInteger)notification {
    if (notification == WGRefreshNotificationTypeLogin) {
        [self loadShopCartList:YES pulling:NO];
    }
    else if (notification == WGRefreshNotificationTypeLogout) {
        [self loadShopCartList:YES pulling:NO];
    }
}

- (void)intoCommitOrderViewController {
    WGCommitOrderViewController *vc = [[WGCommitOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openGoodDetailViewController:(WGShopCartGoodItem *)item {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = item.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAdd:(WGShopCartGoodItem *)item  {
    [self loadUpdateGood:item count:item.goodCount + 1];
}

- (void)handleSub:(WGShopCartGoodItem *)item {
    [self loadUpdateGood:item count:item.goodCount - 1];
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
    return [WGShopCartCell heightWithData:nil];
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
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, [WGShopCartCell heightWithData:nil] - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
        WeakSelf;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.onApply = ^(WGShopCartGoodItem *item) {
            [weakSelf openGoodDetailViewController:item];
        };
        cell.onAdd = ^(WGShopCartGoodItem *item) {
            [weakSelf handleAdd:item];
        };
        cell.onSub = ^(WGShopCartGoodItem *item) {
            [weakSelf handleSub:item];
        };
    }
    [cell showWithData:_data.goods[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WGShopCartGoodItem *item = _data.goods[indexPath.row];
    [self openGoodDetailViewController:item];
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
