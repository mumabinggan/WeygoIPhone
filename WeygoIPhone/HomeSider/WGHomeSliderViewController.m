//
//  WGSidebarViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeSliderViewController.h"
#import "WGSliderTopicCell.h"
#import "WGClassifyItem.h"
#import "WGHomeSliderClassifyHeaderView.h"
#import "WGHomeSliderClassifyItem.h"
#import "WGSliderClassifyItemCell.h"
#import "WGHomeSliderUserHeaderView.h"
#import "WGHomeSliderViewController+Request.h"
#import "WGMessageCenterViewController.h"
#import "WGApplication+Controller.h"
#import "WGNavigationController.h"
#import "WGMessageCenterViewController.h"
#import "WGCouponListViewController.h"
#import "WGOrderListViewController.h"
#import "WGFootPrintViewController.h"
#import "WGClassifyDetailViewController.h"
#import "WGPostCodePopoverView.h"
#import "WGMainViewController.h"
#import "WGPersonInfoViewController.h"

//for test
#import "WGGoodDetailViewController.h"
#import "WGCollectionViewController.h"
#import "WGLoginViewController.h"
#import "WGDealFailGoodView.h"
#import "WGDealShopCartGiftGoodView.h"
#import "WGDeliverPriceView.h"

@interface WGHomeSliderViewController ()
{
    JHTableView *_tableView;
    NSInteger _selectedSection;    //default = -1;
    
    NSArray *_itemArray;
}
@end

@interface WGHomeSliderViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGHomeSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestHomeSlider];
}

- (void)initData {
    [self initItemArray];
}

- (NSArray *)getSubArray:(NSInteger)count {
    NSMutableArray *subMArray = [NSMutableArray array];
    for (int num = 0; num < count; ++num) {
        WGClassifyItem *subItem = [[WGClassifyItem alloc] init];
        subItem.name = [NSString stringWithFormat:@"name_%d", num];
        [subMArray addObject:subItem];
    }
    return subMArray;
}

- (void)initSubView {
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [contentView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchBlankArea:)];
    [self.view addSubview:contentView];
    self.view.backgroundColor = kClearColor;
    _tableView = [[JHTableView alloc] initWithFrame:CGRectMake(0, 0, kWGSideBarWidth, kDeviceHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
}

- (void)touchBlankArea:(id)sender {
    if (self.onTouchBlankArea) {
        self.onTouchBlankArea();
    }
}

- (void)handleOnLogin {
    if ([WGApplication sharedApplication].isLogined) {
        //进入用户信息
        [[WGApplication sharedApplication] closeSideBarViewController];
        WGPersonInfoViewController *vc = [[WGPersonInfoViewController alloc] init];
        WGMainViewController *mainVC = [WGApplication sharedApplication].mainViewController;
        [mainVC.navigationController pushViewController:vc animated:YES];
    }
    else {
        //进入登录界面
        [[WGApplication sharedApplication] closeSideBarViewController];
    }
}

- (void)handleOnScan {
    //进入扫一扫界面
    [[WGApplication sharedApplication] closeSideBarViewController];
}

- (void)handleOnMessageCenter {
    [[WGApplication sharedApplication] closeSideBarViewController];
    WGLoginViewController *vcc = [[WGLoginViewController alloc] init];
    //vcc.goodId = 1591;
    UINavigationController *navc = [WGApplication sharedApplication].navigationController;
    [navc pushViewController:vcc animated:YES];
    return;
//    [[WGApplication sharedApplication] closeSideBarViewController];
//    //进入消息中心
//    WGMessageCenterViewController *vc = [[WGMessageCenterViewController alloc] init];
//    UINavigationController *navc = [WGApplication sharedApplication].navigationController;
//    [navc pushViewController:vc animated:YES];
}

- (void)handleOnApplyHeaderView:(WGClassifyItem *)classify section:(NSInteger)section {
    for (WGClassifyItem *item in _data.classifys) {
        item.isSelected = NO;
    }
    _selectedSection = (section == _selectedSection) ? -1 : section;
    if (_selectedSection != -1) {
        WGClassifyItem *item = _data.classifys[_selectedSection - 2];
        item.isSelected = YES;
    }
    [_tableView reloadData];
}

- (void)refresh {
    _selectedSection = -1;
    [self requestHomeSlider];
}

- (void)refreshUI {
    [_tableView reloadData];
}

- (void)initItemArray {
    _itemArray = @[[NSString safeString:[WGApplication sharedApplication].currentPostCode], kStr(@"Slider_Mine_Order"), kStr(@"Slider_Mine_FootPrint"), kStr(@"Slider_Mine_Coupon"), kStr(@"Slider_Mine_Message")];
}

- (void)handleSetPostCode {
    [self initItemArray];
    [self refreshUI];
}

- (WGClassifyItem *)classifyWithSection:(NSInteger)section {
    return _data.classifys[section - 2];
}

- (WGClassifyItem *)subClassifyWithIndexPath:(NSIndexPath *)indexPath {
    WGClassifyItem *item = [self classifyWithSection:indexPath.section];
    return item.allArray[indexPath.row];
}

- (BOOL)cannotEditPostCode {
    return ([WGApplication sharedApplication].isLogined && ![NSString isNullOrEmpty:[WGApplication sharedApplication].currentPostCode]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGHomeSliderViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger classifyCount = (_data && _data.classifys) ? _data.classifys.count : 0;
    NSInteger topicCount = (_data && _data.topics) ? 1 : 0;
    return classifyCount + topicCount + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else if (section == 1) {
        return (_data.topics.count + 1)/2;
    }
    else {
        WGClassifyItem *item = [self classifyWithSection:section];
        return (_selectedSection == section) ? item.allArray.count : 0;;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kAppAdaptHeight(112);
    }
    else if (section >= 2) {
        return kAppAdaptHeight(48);
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    if (indexPath.section == 0) {
        height = kAppAdaptHeight(48);
    }
    else if (indexPath.section == 1) {
        height = kAppAdaptHeight(74) + (((_data.topics.count + 1)/2 == indexPath.row + 1) ? kAppAdaptHeight(8) : 0.0f);
    }
    else {
        height = kAppAdaptHeight(40);
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return nil;
    }
    static NSString *headerId = nil;
    headerId = [NSString stringWithFormat:@"headerId_%ld", section];
    JHTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headerView) {
        __weak id weakSelf = self;
        if (section == 0) {
            WGHomeSliderUserHeaderView *view = [[WGHomeSliderUserHeaderView alloc] initWithReuseIdentifier:headerId];
            view.backgroundColor = kWhiteColor;
            view.onLogin = ^() {
                [weakSelf handleOnLogin];
            };
            view.onScan = ^() {
                [weakSelf handleOnScan];
            };
            view.onMessageCenter = ^() {
                [weakSelf handleOnMessageCenter];
            };
            headerView = view;
        }
        if (section >= 2) {
            WGHomeSliderClassifyHeaderView *view = [[WGHomeSliderClassifyHeaderView alloc] initWithReuseIdentifier:headerId];
            view.backgroundColor = kWhiteColor;
            view.onApply = ^(WGClassifyItem *item) {
                [weakSelf handleOnApplyHeaderView:item section:section];
            };
            headerView = view;
        }
    }
    if (section == 0) {
        [headerView showWithData:nil];
    }
    if (section >= 2) {
        WGObject *item = [self classifyWithSection:section];
        [headerView showWithData:item];
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    cellId = [NSString stringWithFormat:@"cellId_%ld", (indexPath.row == 0 && indexPath.section == 0) ? -1 : indexPath.section];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (indexPath.section == 0) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else if (indexPath.section == 1) {
            cell = [[WGSliderTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else {
            cell = [[WGSliderClassifyItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.textColor = WGAppTitleColor;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _itemArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = WGAppNameLabelColor;
        cell.contentView.backgroundColor = kWhiteColor;
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"mine_local"];
            cell.accessoryType = [self cannotEditPostCode] ?  UITableViewCellAccessoryNone: UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = WGAppBaseColor;
            cell.contentView.backgroundColor = kHRGB(0xF8FAFA);
        }
    }
    else if (indexPath.section == 1) {
        NSInteger index = indexPath.row * 2;
        NSMutableArray *array = [NSMutableArray arrayWithObjects:_data.topics[index], nil];
        if (index + 1 < _data.topics.count) {
            [array addObject:_data.topics[index + 1]];
        }
        [cell showWithArray:array];
    }
    else {
        WGClassifyItem *subItem = [self subClassifyWithIndexPath:indexPath];
        [cell showWithData:subItem];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[WGApplication sharedApplication] closeSideBarViewController];
    WGViewController *vc = nil;
    WeakSelf;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            if ([self cannotEditPostCode]) {
//                return;
//            }
//            WGHomeFloorContentGoodItem *item = [[WGHomeFloorContentGoodItem alloc] init];
//            item.name = @"fasdfasdfasdfasdf";
//            item.pictureURL = @"";
//            item.chineseName = @"郑渊谦";
//            item.briefDescription = @"要想两行文字大小不同，颜色不同，那加一个UILabel作为UIButton的subview了应该是最方便的实现方式了";
//            item.price = @"932.32";
//            item.currentPrice = @"322.23";
//            
//            WGHomeFloorContentGoodItem *item1 = [[WGHomeFloorContentGoodItem alloc] init];
//            item1.name = @"sadfas";
//            item1.pictureURL = @"";
//            item1.chineseName = @"郑渊谦";
//            item1.briefDescription = @"要想两行文字大小不同，颜色不同，那加一个UILabel作为UIButton的subview了应该是最方便的实现方式了要想两行文字大小不同，颜色不同，那加一个UILabel作为UIButton的subview了应该是最方便的实现方式了";
//            item1.price = @"932.32";
//            item1.currentPrice = @"322.23";
//            WGDealShopCartGiftGoodView *view = [[WGDealShopCartGiftGoodView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//            view.goods = @[item, item1];
            WGDeliverPriceView *view = [[WGDeliverPriceView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
            view.tip = @"要想两行文字大小不同，颜色不同，那加一个UILabel作为UIButton的subview了应该是最方便的实现方式了要想两行文字大小不同，颜色不同，那加一个UILabel作为UIButton的subview了应该是最方便的实现方式了";
//            WGDealFailGoodView *view = [[WGDealFailGoodView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
            //view.tip = @"如果两行文字大小相同，颜色相同，可以直接设置Line Break为Word Wrap，然后在Title中按option+enter就可以增加行数。";
//            WGPostCodePopoverView *view = [[WGPostCodePopoverView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//            view.onApply = ^(NSString *postCode) {
//                [weakSelf handleSetPostCode];
//            };
            [view show];
            //弹出输入邮编
            return;
        }
        else if (indexPath.row == 1) {
            //弹出订单
            vc = [[WGOrderListViewController alloc] init];
        }
        else if (indexPath.row == 2) {
            //足迹
            vc = [[WGFootPrintViewController alloc] init];
        }
        else if (indexPath.row == 3) {
            //优惠卷
            vc = [[WGCouponListViewController alloc] init];
        }
        else if (indexPath.row == 4) {
            //消息
            vc = [[WGMessageCenterViewController alloc] init];
        }
    }
    if (indexPath.section >= 2) {
        //分类详情
        WGClassifyDetailViewController *classifyDetailViewController = [[WGClassifyDetailViewController alloc] init];
        classifyDetailViewController.classifyId = [self subClassifyWithIndexPath:indexPath].id;
        vc = classifyDetailViewController;
    }
    //进入消息中心
    UINavigationController *navc = [WGApplication sharedApplication].navigationController;
    [navc pushViewController:vc animated:YES];
}

@end
