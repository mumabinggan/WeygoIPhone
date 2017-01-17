//
//  WGForeignTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabShopCartViewController.h"
#import "WGShopCartCell.h"

//for test
#import "WGShopCartGoodItem.h"

@interface WGTabShopCartViewController ()
{
    TWRefreshTableView *_tableView;
    
    UIVisualEffectView *_footView;
    JHLabel *_deliveryPriceLabel;
    JHLabel *_totalePriceLabel;
}
@end

@interface WGTabShopCartViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGTabShopCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexForeign;
        self.tabBarItem.title = kStr(@"TabForeign");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_cart_icon"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _data = [[WGShopCart alloc] init];
    _data.deliveryPrice = 99.00;
    _data.totalePrice = 8999.99;
    
    WGShopCartGoodItem *goodItem = [[WGShopCartGoodItem alloc] init];
    goodItem.name = @"香蕉";
    goodItem.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem.price = 9844.99;
    goodItem.reducePrice = 244.99;
    goodItem.price = 8939.99;
    
    WGShopCartGoodItem *goodItem2 = [[WGShopCartGoodItem alloc] init];
    goodItem2.name = @"苹果";
    goodItem2.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem2.price = 1844.99;
    goodItem2.reducePrice = 544.99;
    goodItem2.price = 6939.99;
    
    WGShopCartGoodItem *goodItem3 = [[WGShopCartGoodItem alloc] init];
    goodItem3.name = @"梨";
    goodItem3.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem3.price = 1844.99;
    goodItem3.reducePrice = 544.99;
    goodItem3.price = 6939.99;
    
    WGShopCartGoodItem *goodItem4 = [[WGShopCartGoodItem alloc] init];
    goodItem4.name = @"桔子";
    goodItem4.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem4.price = 1844.99;
    goodItem4.reducePrice = 544.99;
    goodItem4.price = 6939.99;
    
    WGShopCartGoodItem *goodItem5 = [[WGShopCartGoodItem alloc] init];
    goodItem5.name = @"西瓜";
    goodItem5.briefDescription = @"导航条可以看做是self.navigationController导航控制器的一个属";
    goodItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem5.price = 1844.99;
    goodItem5.reducePrice = 544.99;
    goodItem5.price = 6939.99;
    
    _data.goods = @[goodItem, goodItem2, goodItem3, goodItem4, goodItem5];
}

- (void)initSubView {
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, kAppAdaptHeight(108 + 49 - 35), 0);
    [self.view addSubview:_tableView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _footView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _footView.frame = CGRectMake(0, kDeviceHeight - kAppAdaptHeight(108 + 49), kDeviceWidth, kAppAdaptHeight(108));
    [self.view addSubview:_footView];
    _footView.hidden = YES;
    
    JHImageView *deliveryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(20), kAppAdaptWidth(20), kAppAdaptHeight(14))];
    deliveryImageView.image = [UIImage imageNamed:@""];
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
    
    [self refreshTableView];
    
    JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [confirmBtn setTitle:kStr(@"Confirm") forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kAppAdaptFont(14);
    [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(touchConfirmBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:confirmBtn];
}

- (void)touchConfirmBtnBtn:(UIButton *)sender {
    
}

- (void)refreshTableView {
    [_tableView reloadData];
    
    _footView.hidden = !(_data && _data.goods && _data.goods.count);
    
    NSString *deliveryPrice = [NSString stringWithFormat:kStr(@"Price With Unit"), _data.deliveryPrice];
    _deliveryPriceLabel.text = deliveryPrice;
    NSString *totalePrice = [NSString stringWithFormat:kStr(@"Totale:Price With Unit"), _data.totalePrice];
    _totalePriceLabel.text = totalePrice;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGTabShopCartViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_data && _data.goods) ? _data.goods.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(124);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WGShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
    }
    [cell showWithData:_data.goods[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)beginRefreshFooter:(TWRefreshTableView*) tableView {
    
}

@end