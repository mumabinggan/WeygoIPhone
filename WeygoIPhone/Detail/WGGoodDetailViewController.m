//
//  WGGoodDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetailViewController.h"
#import "WGGoodDetailCarouselFiguresCell.h"
#import "WGGoodDesCell.h"
#import "WGGoodConfigInfoCell.h"
#import "WGCommodityDesCell.h"
#import "WGHomeFloorGoodColumnCell.h"
#import "WGGoodDetailViewController+Request.h"
#import "WGGoodAddView.h"
#import "WGGoodInLocalCart.h"
#import "WGPostCodePopoverView.h"
#import "WGViewController+ShopCart.h"
#import "WGHomeFloorContentGoodItem.h"

@interface WGGoodDetailViewController ()
{
    WGGoodAddView *_addView;
    JHButton *_likeBtn;
    JHView *_bottomView;
    
    JHButton *_noAddBtn;
}
@end

@interface WGGoodDetailViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGGoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadGoodDetail];
}

- (void)initSubView {
    [super initSubView];
    
    [self initNavigationItem];
    
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    //[self initNavigationItem];
    CGFloat bottomHeight = kAppAdaptHeight(44);
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, bottomHeight - 35, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    [contentView addSubview:_tableView];
    _tableView.layer.opacity = 0.0;
    
    _bottomView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - bottomHeight, kDeviceWidth, bottomHeight)];
    _bottomView.backgroundColor = kWhiteColor;
    _bottomView.layer.opacity = 0.0;
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [_bottomView addSubview:lineView];
    
    _addView = [[WGGoodAddView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(10), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _addView.fromType = WGGoodAddViewFromGoodDetail;
    _addView.count = 1;
    [_bottomView addSubview:_addView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(_addView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(8), kAppAdaptWidth(210), kAppAdaptHeight(28)) difRadius:JHRadiusMake(kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14)) backgroundColor:WGAppBlueButtonColor];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:kStr(@"Good Detail Add") forState:UIControlStateNormal];
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [_bottomView addSubview:addBtn];
    
    _noAddBtn = [[JHButton alloc] initWithFrame:CGRectMake(_addView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(8), kAppAdaptWidth(210), kAppAdaptHeight(28)) difRadius:JHRadiusMake(kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14)) backgroundColor:kRGB(173, 190, 197)];
    [_noAddBtn setTitle:kStr(@"GoodDetail_Grid_Instock") forState:UIControlStateNormal];
    [_noAddBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _noAddBtn.titleLabel.font = kAppAdaptFont(14);
    [_bottomView addSubview:_noAddBtn];
    
    _likeBtn = [[JHButton alloc] initWithFrame:CGRectMake(addBtn.maxX + kAppAdaptWidth(16), _addView.y + kAppAdaptHeight(3), kAppAdaptWidth(20), kAppAdaptHeight(18))];
    [_likeBtn addTarget:self action:@selector(touchLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn setImage:[UIImage imageNamed:@"good-like-normal"] forState:UIControlStateNormal];
    [_bottomView addSubview:_likeBtn];
    
    [contentView addSubview:_bottomView];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

- (void)refreshUI {
    [self refreshBottomView];
    [_tableView reloadData];
    [UIView animateWithDuration:0.3 animations:^() {
        _tableView.layer.opacity = 1.0;
        _bottomView.layer.opacity = 1.0;
    }];
}

- (void)refreshBottomView {
    _noAddBtn.hidden = _goodDetail.inStock;
    [_likeBtn setImage:[UIImage imageNamed:(_goodDetail.hasFavorited) ? @"good-like-selected" : @"good-like-normal" ] forState:UIControlStateNormal];
}

- (void)touchLikeBtn:(JHButton *)sender {
    if ([WGApplication sharedApplication].isLogined) {
        [self requestCollectGood:(_goodDetail.hasFavorited == 0)];
    }
    else {
        _loginType = WGLoginTypeGoodDetailFavorite;
        [self openLoginViewController];
    }
}

- (void)handleLoginSuccess:(id)customData {
    [super handleLoginSuccess:customData];
    if (_loginType == WGLoginTypeGoodDetailFavorite) {
        _loginType = WGLoginTypeNormal;
        [self loadGoodDetail];
    }
}

- (void)touchAddBtn:(JHButton *)sender {
    if ([NSString isNullOrEmpty:[WGApplication sharedApplication].currentPostCode]) {
        WGPostCodePopoverView *view = [[WGPostCodePopoverView alloc] initWithFrame:self.view.bounds];
        [view showInView:self.view];
        return;
    }
    [[WGApplication sharedApplication] loadAddGoodToCart:_goodDetail.id count:_addView.count onCompletion:^(WGAddGoodToCartResponse *response) {
        [self showWarningMessage:response.message];
    }];
    [[WGApplication sharedApplication] handleShopCartGoodCount:_addView.count];
}

- (void)handleRecommendGood:(WGHomeFloorContentItem *)item {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = item.id;
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
}

@end

@implementation WGGoodDetailViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodDetail ? 5 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    if (0 == indexPath.row) {
        height = [WGGoodDetailCarouselFiguresCell heightWithData:_goodDetail.carouselFigures];
    }
    else if (1 == indexPath.row) {
        height = [WGGoodConfigInfoCell heightWithData:_goodDetail];
    }
    else if (2 == indexPath.row) {
        height = [WGGoodDesCell heightWithData:_goodDetail];
    }
    else if (3 == indexPath.row) {
        height = [WGCommodityDesCell heightWithData:_goodDetail];
    }
    else if (4 == indexPath.row) {
        height = [WGHomeFloorGoodColumnCell heightWithArray:_goodDetail.recommendProduce];
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [NSString stringWithFormat:@"cellId_%ld", indexPath.row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (0 == indexPath.row) {
            cell = [[WGGoodDetailCarouselFiguresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (1 == indexPath.row) {
            cell = [[WGGoodConfigInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (2 == indexPath.row) {
            cell = [[WGGoodDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColor = kHRGB(0xF8FAFA);
        }
        else if (3 == indexPath.row) {
            cell = [[WGCommodityDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (4 == indexPath.row) {
            WeakSelf;
            WGHomeFloorGoodColumnCell *goodCell = [[WGHomeFloorGoodColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            goodCell.onApply = ^(WGHomeFloorContentItem *item) {
                [weakSelf handleRecommendGood:item];
            };
            cell = goodCell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.clipsToBounds = YES;
        cell.clipsToBounds = YES;
    }
    if (indexPath.row == 0) {
        [cell showWithArray:_goodDetail.carouselFiguresPictureArray];
    }
    else if (indexPath.row == 4) {
        [cell showWithArray:_goodDetail.recommendProduce];
    }
    else {
        [cell showWithData:_goodDetail];
    }
    return cell;
}

@end
