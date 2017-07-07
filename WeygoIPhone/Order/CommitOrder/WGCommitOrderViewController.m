//
//  WGCommitOrderViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController.h"
#import "WGCommitOrderAddressCell.h"
#import "WGCommitOrderFaxCell.h"
#import "WGCommitOrderCouponCell.h"
#import "WGCommitOrderConsumeCell.h"
#import "WGCommitOrderRemarkCell.h"
#import "WGCommitOrderLookMoreCell.h"
#import "WGOrderListGoodsCell.h"
#import "WGCommitOrderDeliverTipCell.h"
#import "WGCommitOrderViewController+Request.h"
#import "WGSettlementResult.h"
#import "WGAddressListViewController.h"
#import "WGCouponListViewController.h"
#import "WGReceiptCode.h"
#import "WGGoodDetailViewController.h"
#import "WGEditReceiptViewController.h"
#import "WGUseIntegrationViewController.h"
#import "WGCommitOrderViewController+PickerView.h"
#import "WGIntegrationHelpView.h"

@interface WGCommitOrderViewController ()
{
    JHView *_contentView;
    WGCommitOrderRemarkCell *_remarkCell;
    JHLabel *_totalPriceLabel;
    JHLabel *_reducePriceLabel;
    JHView *_bottomView;
    UIButton *_confirmBtn;
}
@end

@interface WGCommitOrderViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGCommitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSettlementResultDetail];
}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"CommitOrder Title");
    _contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    
    //[self initNavigationItem];
    CGFloat bottomHeight = kAppAdaptHeight(108);
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomHeight, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_tableView];
}

- (void)refreshUI {
    [_tableView reloadData];
    
    if (!_bottomView) {
        _bottomView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(108), kDeviceWidth, kAppAdaptHeight(108))];
        _bottomView.backgroundColor = kHRGBA(0xffffff, 0.8);
        [_contentView addSubview:_bottomView];
        
        _totalPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(18), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
        _totalPriceLabel.font = kAppAdaptFont(14);
        _totalPriceLabel.textColor = WGAppBaseColor;
        [_bottomView addSubview:_totalPriceLabel];
        
        _reducePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_totalPriceLabel.x, _totalPriceLabel.y + kAppAdaptHeight(2), 120, kAppAdaptHeight(16))];
        _reducePriceLabel.font = kAppAdaptFont(12);
        _reducePriceLabel.textColor = kWhiteColor;
        _reducePriceLabel.textAlignment = NSTextAlignmentCenter;
        _reducePriceLabel.backgroundColor = WGAppBaseColor;
        _reducePriceLabel.layer.cornerRadius = kAppAdaptWidth(3);
        _reducePriceLabel.layer.masksToBounds = YES;
        [_bottomView addSubview:_reducePriceLabel];
        
//        _confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40))];
        _confirmBtn.layer.cornerRadius = kAppAdaptHeight(20);
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(touchCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:kStr(@"CommitOrder Confirm") forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kAppAdaptFont(14);
        [_bottomView addSubview:_confirmBtn];
    }
    
    NSString *totalPrice = [NSString stringWithFormat:kStr(@"CommitOrder Total Pay"), _commitOrderDetail.consumePrice.currentTotalPrice];
    _totalPriceLabel.text = totalPrice;
    CGSize size = [totalPrice returnSize:_totalPriceLabel.font];
    _totalPriceLabel.width = size.width;
    NSString *reducePrice = _commitOrderDetail.consumePrice.reducePrice;
    _reducePriceLabel.text = reducePrice;
    size = [_commitOrderDetail.consumePrice.reducePrice returnSize:_totalPriceLabel.font];
    _reducePriceLabel.width = size.width + kAppAdaptWidth(12);
    _reducePriceLabel.x = _totalPriceLabel.maxX + kAppAdaptWidth(22);
    _reducePriceLabel.hidden = [NSString isNullOrEmpty:reducePrice];
    
    [_confirmBtn setBackgroundColor:[self enableConfirm] ? WGAppFooterButtonColor : kRGB(173, 190, 197)];
}

- (BOOL)enableConfirm {
    if (_commitOrderDetail) {
        return [NSString isNullOrEmpty:_commitOrderDetail.minPriceTips];
    }
    return NO;
}

- (void)touchCommitBtn:(JHButton *)sender {
    if ([self enableConfirm]) {
        [self loadCommitOrder];
    }
}

- (void)showOverWeightView {
    [_overWeightView close];
    WeakSelf;
    _overWeightView = [[WGOverweightView alloc] initWithFrame:self.view.bounds overHeightDetail:_overWeightArray];
    _overWeightView.onDelete = ^(NSArray *datail) {
        [weakSelf loadDeleteOverHeight];
    };
    _overWeightView.onConfirm = ^(NSArray *datail) {
        [weakSelf loadOverHeightReset:datail];
    };
    [_overWeightView showInView:self.view];
}

- (void)handleMoreTip:(WGSettlementTips *)tip {
    WGIntegrationHelpView *view = [[WGIntegrationHelpView alloc] initWithFrame:self.view.bounds];
    view.tip = tip.orderPriceDetailTip;
    view.type = 1;
    [view showInView:self.view];
}

- (void)handleAddress:(WGAddress *)address {
    _commitOrderDetail.address = address;
    [self loadOverHeightDetail];
    [self refreshUI];
}

- (void)handleReceipt:(WGReceipt *)receipt {
    _commitOrderDetail.receipt = receipt;
    [self refreshUI];
}

- (void)handleCoupon:(WGCoupon *)coupon price:(WGSettlementConsumePrice *)price {
    _commitOrderDetail.coupon = coupon;
    _commitOrderDetail.consumePrice = price;
    [self refreshUI];
    //[self loadUpdateOrderCoupon];
}

- (void)handleIntegration:(WGSettlementConsumePrice *)price use:(WGIntegrationState)use {
    _commitOrderDetail.useIntegration = use;
    _commitOrderDetail.consumePrice = price;
    [self refreshUI];
}

- (void)handleGood:(WGOrderGoodItem *)good {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = good.id;
    vc.title = good.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGCommitOrderViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_commitOrderDetail) ? 9 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (0 == section) {
        count = 1;
    }
    else if (1 == section) {
        count = 2;
    }
    else if (2 == section) {
        count = 3;
    }
    else if (3 == section) {
        count = 4;
    }
    else if (4 == section) {
        count = 2;
    }
    else if (5 == section) {
        count = 3;
    }
    else if (6 == section) {
        count = 1;
    }
    else if (7 == section) {
        count = 1;
    }
    else if (8 == section) {
        count = 1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kAppAdaptHeight(10);
    }
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kAppAdaptHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (0 == section) {
        height = [WGCommitOrderAddressCell heightWithData:_commitOrderDetail.address];
    }
    else if (1 == section) {
        if (1 == row) {
            height = [WGCommitOrderFaxCell heightWithData:_commitOrderDetail.receipt];
        }
        else {
            height = kAppAdaptHeight(40);
        }
    }
    else if (2 == section) {
        if (0 == row) {
            height = kAppAdaptHeight(40);
        }
        else {
            height = kAppAdaptHeight(48);
        }
    }
    else if (3 == section) {
        if (0 == row) {
            height = kAppAdaptHeight(40);
        }
        else if (2 == row) {
            height = kAppAdaptHeight(48);
        }
        else if (3 == row) {
            height = [WGCommitOrderCouponCell heightWithData:_commitOrderDetail.coupon];
        }
        else {
            height = _commitOrderDetail.integration > 0 ? kAppAdaptHeight(40) : 0;
        }
    }
    else if (4 == section) {
        if (1 == row) {
            height = [WGCommitOrderConsumeCell heightWithData:_commitOrderDetail.consumePrice];
        }
        else {
            height = kAppAdaptHeight(40);
        }
    }
    else if (5 == section) {
        if (0 == row) {
            height = kAppAdaptHeight(40);
        }
        else if (1 == row) {
            height = [WGOrderListGoodsCell heightWithArray:_commitOrderDetail.goods];
        }
        else {
            height = [WGCommitOrderRemarkCell heightWithData:nil];
        }
    }
    else if (6 == section) {
        height = [WGCommitOrderDeliverTipCell heightWithData:_commitOrderDetail.tip];
    }
    else if (7 == section) {
        height = [WGCommitOrderLookMoreCell heightWithData:_commitOrderDetail.tip];
    }
    else if (8 == section) {
        height = [NSString isNullOrEmpty:_commitOrderDetail.minPriceTips] ? 0 : kAppAdaptHeight(40);
    }
    return height;
}

- (BOOL)systemCell:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    return ((section == 1 && row == 0) ||
            (section == 2 && row == 0) ||
            (section == 3 && row == 0) ||
            (section == 4 && row == 0) ||
            (section == 5 && row == 0) ||
            (section == 8 && row == 0));
}

- (NSString *)getIdentifier:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if ([self systemCell:indexPath]) {
        identifier = @"cellId";
    }
    else if (section == 1 && row == 1) {
        identifier = [NSString stringWithFormat:@"cellId_%ld_%ld_%d", section, row, (_commitOrderDetail.receipt) ? YES : NO];
    } else
    {
        identifier = [NSString stringWithFormat:@"cellId_%ld_%ld", section, row];
    }
    return identifier;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [self getIdentifier:indexPath];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (!cell) {
        if ([self systemCell:indexPath]) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.font = kAppAdaptFontBold(14);
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.contentView.backgroundColor = kHRGB(0xF8FAFA);
        }
        else {
            if (section == 0) {
                cell = [[WGCommitOrderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (section == 1) {
                cell = [[WGCommitOrderFaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (section == 2) {
                cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.textLabel.font = kAppAdaptFont(14);
                cell.textLabel.textColor = WGAppTitleColor;
                cell.detailTextLabel.font = cell.textLabel.font;
                cell.detailTextLabel.textColor = WGAppNameLabelColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (section == 3) {
                if (1 == row || 2 == row) {
                    cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.textLabel.font = kAppAdaptFont(14);
                    cell.textLabel.textColor = WGAppTitleColor;
                    cell.detailTextLabel.font = cell.textLabel.font;
                    cell.detailTextLabel.textColor = WGAppNameLabelColor;
                }
                else {
                    cell = [[WGCommitOrderCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (section == 4) {
                cell = [[WGCommitOrderConsumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (section == 5) {
                if (1 == row) {
                    __weak id weakSelf = self;
                    WGOrderListGoodsCell *goodsCell = [[WGOrderListGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fasdfasdafsa"];
                    goodsCell.onApply = ^(WGOrderGoodItem *good) {
                        [weakSelf handleGood:good];
                    };
                    cell = goodsCell;
                }
                else {
                    _remarkCell = [[WGCommitOrderRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell = _remarkCell;
                }
            }
            else if (section == 6) {
                cell = [[WGCommitOrderDeliverTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (section == 7) {
                __weak id weakSelf = self;
                WGCommitOrderLookMoreCell *moreCell = [[WGCommitOrderLookMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                moreCell.onMore = ^(WGSettlementTips *tip) {
                    [weakSelf handleMoreTip:tip];
                };
                cell = moreCell;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        cell.contentView.clipsToBounds = YES;
    }
    if (0 == section) {
        [cell showWithData:_commitOrderDetail.address];
    }
    else if (1 == section) {
        if (0 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Fax");
        }
        else {
            [cell showWithData:_commitOrderDetail.receipt];
        }
    }
    else if (2 == section) {
        if (0 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Deliver");
        }
        else if (1 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Deliver Date");
            cell.detailTextLabel.text = _commitOrderDetail.deliverTime.currentDate;
        }
        else if (2 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Deliver Time");
            cell.detailTextLabel.text = _commitOrderDetail.deliverTime.currentTime;
        }
    }
    else if (3 == section) {
        if (0 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Pay");
        }
        else if (1 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Use Score");
            cell.detailTextLabel.text = _commitOrderDetail.useIntegrationString;
        }
        else if (2 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Pay");
            cell.detailTextLabel.text = _commitOrderDetail.payMothod.payName;
        }
        else {
            [cell showWithData:_commitOrderDetail.coupon];
        }
    }
    else if (4 == section) {
        if (0 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Consume");
        }
        else {
            [cell showWithData:_commitOrderDetail.consumePrice];
        }
    }
    else if (5 == section) {
        if (0 == row) {
            cell.textLabel.text = kStr(@"CommitOrder Consume List");
        }
        else if (1 == row) {
            [cell showWithArray:_commitOrderDetail.goods];
        }
    }
    else if (6 == section) {
        [cell showWithData:_commitOrderDetail.tip];
    }
    else if (7 == section) {
        [cell showWithData:_commitOrderDetail.tip];
    }
    else if (8 == section) {
        cell.textLabel.text = _commitOrderDetail.minPriceTips;
    }
    if ([self systemCell:indexPath]) {
        if (indexPath.section == 8) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = WGAppBaseColor;
            cell.contentView.backgroundColor = kWhiteColor;
        }
        else {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.contentView.backgroundColor = kHRGB(0xF8FAFA);
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    __weak id weakSelf = self;
    if (section == 0) {
        WGAddressListViewController *vc = [[WGAddressListViewController alloc] init];
        vc.type = WGAddressListTypeCanUse;
        vc.onUse = ^(JHObject *object) {
            [weakSelf handleAddress:(WGAddress *)object];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (section == 1) {
        if (row == 1) {
            WGEditReceiptViewController *vc = [[WGEditReceiptViewController alloc] init];
            vc.receipt = _commitOrderDetail.receipt;
            vc.onApply = ^(WGReceipt *object) {
                [weakSelf handleReceipt:(WGReceipt *)object];
            };
            vc.onCancel = ^() {
                [weakSelf handleReceipt:nil];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (section == 2) {
        if (row == 1) {
            //日期
            [self initPickerView:1000];
        }
        else if (row == 2) {
            //时间
            [self initPickerView:1001];
        }
    }
    else if (section == 3) {
        if (row == 1) {
            WeakSelf;
            WGUseIntegrationViewController *vc = [[WGUseIntegrationViewController alloc] init];
            vc.onApply = ^(WGSettlementConsumePrice *price, WGIntegrationState use) {
                [weakSelf handleIntegration:price use:use];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 2) {
            //付款方式
            [self initPickerView:1002];
        }
        else if (row == 3) {
            WGCouponListViewController *vc = [[WGCouponListViewController alloc] init];
            vc.isSelect = YES;
            vc.coupon = _commitOrderDetail.coupon;
            vc.onUse = ^(JHObject *object, WGSettlementConsumePrice *price) {
                [weakSelf handleCoupon:(WGCoupon *)object price:price];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
