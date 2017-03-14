//
//  WGGoodDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetailViewController.h"
#import "WGHomeCarouselFiguresCell.h"
#import "WGGoodDesCell.h"
#import "WGGoodConfigInfoCell.h"
#import "WGCommodityDesCell.h"
#import "WGHomeFloorGoodColumnCell.h"
#import "WGGoodDetailViewController+Request.h"
#import "WGGoodAddView.h"
#import "WGGoodInLocalCart.h"

@interface WGGoodDetailViewController ()
{
    WGGoodAddView *_addView;
    JHButton *_likeBtn;
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
    
    JHView *bottomView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - bottomHeight, kDeviceWidth, bottomHeight)];
    bottomView.backgroundColor = kWhiteColor;
    
    _addView = [[WGGoodAddView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(10), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _addView.fromType = WGGoodAddViewFromGoodDetail;
    [bottomView addSubview:_addView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(_addView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(8), kAppAdaptWidth(210), kAppAdaptHeight(28)) difRadius:JHRadiusMake(kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14), kAppAdaptHeight(14)) backgroundColor:WGAppBlueButtonColor];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:kStr(@"Good Detail Add") forState:UIControlStateNormal];
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [bottomView addSubview:addBtn];
    
    _likeBtn = [[JHButton alloc] initWithFrame:CGRectMake(addBtn.maxX + kAppAdaptWidth(16), _addView.y + kAppAdaptHeight(3), kAppAdaptWidth(20), kAppAdaptHeight(18))];
    [_likeBtn addTarget:self action:@selector(touchLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn setImage:[UIImage imageNamed:@"good-like-normal"] forState:UIControlStateNormal];
    [bottomView addSubview:_likeBtn];
    
    [contentView addSubview:bottomView];
}

- (void)refreshUI {
    [self refreshBottomView];
    [_tableView reloadData];
}

- (void)refreshBottomView {
    [_likeBtn setImage:[UIImage imageNamed:(_goodDetail.hasFavorited) ? @"good-like-selected" : @"good-like-normal" ] forState:UIControlStateNormal];
}

- (void)touchLikeBtn:(JHButton *)sender {
    if ([WGApplication sharedApplication].isLogined) {
        [self requestCollectGood:!_goodDetail.hasFavorited];
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
    if ([WGApplication sharedApplication].isLogined) {
        [[WGApplication sharedApplication] loadAddGoodToCart:_goodDetail.id count:_addView.count onCompletion:^(WGAddGoodToCartResponse *response) {
            [self showWarningMessage:response.message];
        }];
    }
    else {
        WGGoodInLocalCart *good = [[WGGoodInLocalCart alloc] init];
        good.id = _goodDetail.id;
        good.count = _addView.count;
        [[WGApplication sharedApplication] addGoodToLocalCart:good];
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
        height = [WGHomeCarouselFiguresCell heightWithData:_goodDetail.carouselFigures];
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
            cell = [[WGHomeCarouselFiguresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (1 == indexPath.row) {
            cell = [[WGGoodConfigInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (2 == indexPath.row) {
            cell = [[WGGoodDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (3 == indexPath.row) {
            cell = [[WGCommodityDesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (4 == indexPath.row) {
            cell = [[WGHomeFloorGoodColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
