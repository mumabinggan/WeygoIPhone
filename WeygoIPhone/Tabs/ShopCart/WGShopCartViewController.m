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
    UIButton *_confirmBtn;
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
    
    JHImageView *deleteImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(19), kAppAdaptWidth(17), kAppAdaptHeight(17))];
    deleteImageView.image = [UIImage imageNamed:@"shopcart_clean"];
    [_footView.contentView addSubview:deleteImageView];
    deleteImageView.userInteractionEnabled = YES;
    _footView.layer.opacity = 0.0f;
    
    [deleteImageView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchCleanShopCart:)];
    
    JHLabel *deleteLabel = [[JHLabel alloc] initWithFrame:CGRectMake(deleteImageView.maxX + kAppAdaptWidth(5), kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16 + 20 + 5), kAppAdaptHeight(20))];
    deleteLabel.font = kAppAdaptFont(14);
    deleteLabel.text = kStr(@"ShopCart_Clean");
    deleteLabel.textColor = WGAppTitleColor;
    deleteLabel.userInteractionEnabled = YES;
    [_footView.contentView addSubview:deleteLabel];
    [deleteLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(touchCleanShopCart:)];
    
    JHImageView *deliveryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 - kAppAdaptWidth(22), kAppAdaptHeight(20), kAppAdaptWidth(20), kAppAdaptHeight(14))];
    deliveryImageView.image = [UIImage imageNamed:@"deliver_car"];
    [_footView.contentView addSubview:deliveryImageView];
    _footView.layer.opacity = 0.0f;
    
    _deliveryPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(deliveryImageView.maxX + kAppAdaptWidth(5), kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16 + 20 + 5), kAppAdaptHeight(20))];
    _deliveryPriceLabel.font = kAppAdaptFont(14);
    _deliveryPriceLabel.textColor = WGAppTitleColor;
    [_footView.contentView addSubview:_deliveryPriceLabel];
    
    _totalePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kAppAdaptHeight(18), kDeviceWidth/2 - kAppAdaptWidth(16), kAppAdaptHeight(20))];
    _totalePriceLabel.font = kAppAdaptFont(14);
    _totalePriceLabel.textColor = WGAppBaseColor;
    _totalePriceLabel.textAlignment = NSTextAlignmentRight;
    [_footView.contentView addSubview:_totalePriceLabel];
    
    //_confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40))];
    [_confirmBtn setBackgroundColor:WGAppFooterButtonColor];
    _confirmBtn.layer.cornerRadius = kAppAdaptHeight(20);
    
    [_confirmBtn setTitle:kStr(@"ShopCart_Confirm") forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kAppAdaptFont(14);
    [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(touchConfirmBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footView.contentView addSubview:_confirmBtn];
    //[self refreshTableView];
}

- (void)touchConfirmBtnBtn:(UIButton *)sender {
    if (![self enableConfirm]) {
        return;
    }
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

- (BOOL)enableConfirm {
    return [NSString isNullOrEmpty:_data.minPriceTips];
}

- (void)refreshUI {
    [self refreshTableView];
    _footView.hidden = !(_data && _data.goods && _data.goods.count);
    NSString *deliveryPrice = _data.shopCartPrice.deliveryPrice;
    _deliveryPriceLabel.text = deliveryPrice;
    NSString *totalePrice = _data.shopCartPrice.totalePrice;
    _totalePriceLabel.text = [NSString stringWithFormat:kStr(@"Totale:Price With String Unit"), totalePrice];
    [UIView animateWithDuration:0.05 animations:^() {
        _tableView.layer.opacity = 1.0f;
        _footView.layer.opacity = 1.0f;
    }];
    [_confirmBtn setBackgroundColor:[self enableConfirm] ? WGAppFooterButtonColor : kRGB(173, 190, 197)];
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
    vc.title = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleAdd:(WGShopCartGoodItem *)item  {
    [self loadUpdateGood:item count:item.goodCount + 1];
}

- (void)handleSub:(WGShopCartGoodItem *)item {
    [self loadUpdateGood:item count:item.goodCount - 1];
}

- (BOOL)isMinPriceTipsCell:(NSIndexPath *)indexPath {
    return indexPath.row == _data.goods.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGShopCartViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_data && _data.goods) ? _data.goods.count + ([NSString isNullOrEmpty:_data.minPriceTips] ? 0 : 1) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = [WGShopCartCell heightWithData:nil];
    if ([self isMinPriceTipsCell:indexPath]) {
        height = kAppAdaptHeight(40);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    cellId = [NSString stringWithFormat:@"cellId_%d", [self isMinPriceTipsCell:indexPath]];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if ([self isMinPriceTipsCell:indexPath]) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.font = kAppAdaptFontBold(14);
            cell.textLabel.textColor = WGAppBaseColor;
            cell.contentView.backgroundColor = kWhiteColor;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        else {
            WGShopCartCell *shopCartCell = [[WGShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, [WGShopCartCell heightWithData:nil] - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
            line.backgroundColor = WGAppSeparateLineColor;
            [shopCartCell.contentView addSubview:line];
            WeakSelf;
            shopCartCell.selectionStyle = UITableViewCellSelectionStyleNone;
            shopCartCell.onApply = ^(WGShopCartGoodItem *item) {
                [weakSelf openGoodDetailViewController:item];
            };
            shopCartCell.onAdd = ^(WGShopCartGoodItem *item) {
                [weakSelf handleAdd:item];
            };
            shopCartCell.onSub = ^(WGShopCartGoodItem *item) {
                [weakSelf handleSub:item];
            };
            cell = shopCartCell;
        }
    }
    if ([self isMinPriceTipsCell:indexPath]) {
        cell.textLabel.text = _data.minPriceTips;
    }
    else {
        [cell showWithData:_data.goods[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isMinPriceTipsCell:indexPath]) {
        WGShopCartGoodItem *item = _data.goods[indexPath.row];
        [self openGoodDetailViewController:item];
    }
}

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return kStr(@"Collection_Delete");
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isMinPriceTipsCell:indexPath]) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && ![self isMinPriceTipsCell:indexPath]) {
        [self loadDeleteIndexPath:indexPath];
    }
}

@end
