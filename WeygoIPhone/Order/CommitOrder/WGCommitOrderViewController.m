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

@interface WGCommitOrderViewController ()
{
    JHView *_contentView;
    WGCommitOrderRemarkCell *_remarkCell;
    JHLabel *_totalPriceLabel;
    JHLabel *_reducePriceLabel;
    JHView *_bottomView;
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

//- (void)initData {
//    WGSettlementResult *result = [[WGSettlementResult alloc] init];
//    result.id = 12122;
//    
//    WGSettlementDate *date = [[WGSettlementDate alloc] init];
//    date.id = @"2323";
//    date.date = @"20170321";
//    WGSettlementTime *time = [[WGSettlementTime alloc] init];
//    time.id = 23;
//    time.time = @"12:00-18:00";
//    WGSettlementTime *time2 = [[WGSettlementTime alloc] init];
//    time2.id = 21;
//    time2.time = @"12:00-19:00";
//    WGSettlementTime *time3 = [[WGSettlementTime alloc] init];
//    time3.id = 223;
//    time3.time = @"2:00-18:00";
//    date.times = @[time, time2, time3];
//    
//    WGSettlementDate *date2 = [[WGSettlementDate alloc] init];
//    date2.id = @"2323";
//    date2.date = @"20170319";
//    date2.times = @[time3, time];
//    
//    result.deliverTimes = @[date, date2];
//    
//    WGSettlementPayMethod *payMethod = [[WGSettlementPayMethod alloc] init];
//    payMethod.id = @"2";
//    payMethod.name = @"在线";
//    
//    WGSettlementPayMethod *payMethod2 = [[WGSettlementPayMethod alloc] init];
//    payMethod2.id = @"3";
//    payMethod2.name = @"支付宝";
//    
//    result.payMethods = @[payMethod, payMethod2];
//    
//    WGSettlementConsumePrice *price = [[WGSettlementConsumePrice alloc] init];
//    price.totalPrice = @"34.23";
//    price.currentTotalPrice = @"5634.32";
//    price.reducePrice = @"23.23";
//    price.deliverPrice = @"3.23";
//    price.couponPrice = @"23.323";
//    
//    result.price = price;
//    
//    WGSettlementTips *tip = [[WGSettlementTips alloc] init];
//    tip.orderPriceDetailTip = @"“华夏”一词最早见于周朝《尚书·周书·武成》，“华夏蛮貊，罔不率俾”。 《书经》曰：“冕服采装曰华，大国曰夏”。《尚书正义》注：“冕服华章曰华，大国曰夏”。“华”，是指华丽、兴旺；也有说上古华、夏同音，本一字。《左传》曰：“中国有礼仪之大，故称夏；有服章之美，谓之华。”[9]  华是指汉服，夏指行周礼的大国，故中国有礼仪之邦、衣冠上国之美誉。";
//    tip.orderChangeTip = @"是以华夏文明为源泉、中华文化为基础，并以汉族为主体民族的多民族国家，通用汉语、汉字，汉族与少数民族被统称为“中华民族”，又自称为炎黄子孙、龙的";
//    tip.orderPriceTip = @"中国政府网由国务院办公厅主办,中国政府网运行中心负责运行维护,是国务院和国务院各部门,以及各省、自治区、直辖市人民政府在国际互联网上发布政府信息和提供在线服务的";
//    
//    result.tip = tip;
//    
//    WGOrderGoodItem *goodItem = [[WGOrderGoodItem alloc] init];
//    goodItem.number = 12;
//    goodItem.orderPrice = @"123.32";
//    goodItem.orderCurrentPrice = @"54.23";
//    goodItem.orderReducePrice = @"43.23";
//    goodItem.name = @"fasdfasdfasdfasdf";
//    goodItem.pictureURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//    goodItem.chineseName = @"郑渊谦";
//    goodItem.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem.price = @"932.32";
//    goodItem.currentPrice = @"322.23";
//    
//    WGOrderGoodItem *goodItem1 = [[WGOrderGoodItem alloc] init];
//    goodItem1.number = 1;
//    goodItem1.orderPrice = @"123.32";
//    goodItem1.orderCurrentPrice = @"54.23";
//    goodItem1.orderReducePrice = @"43.23";
//    goodItem1.name = @"sadfas";
//    goodItem1.pictureURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//    goodItem1.chineseName = @"郑渊谦";
//    goodItem1.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem1.price = @"932.32";
//    goodItem1.currentPrice = @"322.23";
//    
//    WGOrderGoodItem *goodItem2 = [[WGOrderGoodItem alloc] init];
//    goodItem2.number = 4;
//    goodItem2.orderPrice = @"123.32";
//    goodItem2.orderCurrentPrice = @"54.23";
//    goodItem2.orderReducePrice = @"43.23";
//    goodItem2.name = @"zhengasdfl";
//    goodItem2.pictureURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//    goodItem2.chineseName = @"郑渊谦";
//    goodItem2.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem2.price = @"932.32";
//    goodItem2.currentPrice = @"122.23";
//    
//    WGOrderGoodItem *goodItem3 = [[WGOrderGoodItem alloc] init];
//    goodItem3.number = 8;
//    goodItem3.orderPrice = @"123.32";
//    goodItem3.orderCurrentPrice = @"54.23";
//    goodItem3.orderReducePrice = @"43.23";
//    goodItem3.name = @"zhengasdfl";
//    goodItem3.pictureURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//    goodItem3.chineseName = @"郑渊谦";
//    goodItem3.briefDescription = @"asdfasdfasdfasdfasdfas";
//    goodItem3.price = @"932.32";
//    goodItem3.currentPrice = @"122.23";
//    
//    result.goods = @[goodItem, goodItem1, goodItem2, goodItem3];
//    
//    _commitOrderDetail = [[WGCommitOrderDetail alloc] initWithSettlementResult:result];
//    
//}

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
    
    [self refreshUI];
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
        
        _reducePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_totalPriceLabel.x, _totalPriceLabel.y, 120, kAppAdaptHeight(16))];
        _reducePriceLabel.font = kWGOswaldRegularFont(12);
        _reducePriceLabel.font = kAppAdaptFont(12);
        _reducePriceLabel.textColor = kWhiteColor;
        _reducePriceLabel.textAlignment = NSTextAlignmentCenter;
        _reducePriceLabel.backgroundColor = WGAppBaseColor;
        _reducePriceLabel.layer.cornerRadius = kAppAdaptWidth(3);
        _reducePriceLabel.layer.masksToBounds = YES;
        [_bottomView addSubview:_reducePriceLabel];
        
        JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
        [addBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitle:kStr(@"CommitOrder Confirm") forState:UIControlStateNormal];
        [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        addBtn.titleLabel.font = kAppAdaptFont(14);
        [_bottomView addSubview:addBtn];
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
}

- (void)touchConfirmBtn:(JHButton *)sender {
    [self loadCommitOrder];
}

- (void)handleMoreTip:(WGSettlementTips *)tip {
    //
}

- (void)handleAddress:(WGAddress *)address {
    _commitOrderDetail.address = address;
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

- (void)handleGood:(WGOrderGoodItem *)good {
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    vc.goodId = good.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGCommitOrderViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_commitOrderDetail) ? 8 : 0;
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
    return height;
}

- (BOOL)systemCell:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    return ((section == 1 && row == 0) ||
            (section == 2 && row == 0) ||
            (section == 3 && row == 0) ||
            (section == 4 && row == 0) ||
            (section == 5 && row == 0) );
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
            cell.textLabel.font = kAppAdaptFont(14);
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
            WGUseIntegrationViewController *vc = [[WGUseIntegrationViewController alloc] init];
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
