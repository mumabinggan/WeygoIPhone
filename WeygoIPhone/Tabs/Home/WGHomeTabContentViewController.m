//
//  WGHomeTabContentViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabContentViewController.h"
#import "WGHomeFloorItem.h"
#import "WGHomeCarouselFiguresCell.h"
#import "WGHomeTopicCell.h"
#import "WGNews.h"
#import "WGHomeNewsCell.h"
#import "WGHomeFloorNameHeadCell.h"
#import "WGHomeFloorNameAndBriefInfoHeadCell.h"
#import "WGHomeFloorPictureHeadCell.h"
#import "WGHomeFloorCountryCell.h"
#import "WGHomeFloorClassifyListItemCell.h"
#import "WGHomeFloorClassifyColumnCell.h"
#import "WGHomeFloorClassifyGridItemCell.h"
#import "WGHomeFloorGoodGridItemCell.h"
#import "WGHomeFloorGoodColumnCell.h"
#import "WGHomeFloorGoodListMoreCell.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGRegisterViewController.h"
#import "WGInvitationViewController.h"
#import "WGSpecialClassifyViewController.h"
#import "WGSpecialClassifyGoodViewController.h"
#import "WGSpecialClassifyViewController.h"
#import "WGGoodDetailViewController.h"
#import "WGTabBenefitViewController.h"
#import "WGHomeTabViewController.h"

//for test
#import "WGClassifyGoodListViewController.h"
#import "WGAddressListViewController.h"
#import "WGCouponListViewController.h"
#import "WGCollectionViewController.h"
#import "WGFootPrintViewController.h"
#import "WGSettingViewController.h"
#import "WGShopCartViewController.h"
#import "WGClassifyDetailViewController.h"
#import "WGLoginViewController.h"
#import "WGBindThirdPartyViewController.h"
#import "WGClientServiceCenterViewController.h"
#import "WGGoodDetailViewController.h"
#import "WGOrderDetailViewController.h"
#import "WGOrderListViewController.h"
#import "WGMessageCenterViewController.h"
#import "WGCommitOrderViewController.h"
#import "WGInvitationViewController.h"
#import "WGSearchViewController.h"

//can delete
#import "WGCarouselFigureItem.h"
#import "WGTopicItem.h"
#import "WGNewsItem.h"
#import "WGHomeFloorItem.h"
#import "WGHomeFloorContentItem.h"
#import "WGHomeTabContentViewController+Request.h"

@interface WGHomeTabContentViewController ()

@end

@interface WGHomeTabContentViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGHomeTabContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DLog(@"--homeTabContent---%f----", self.view.height);
    //[self loadData];
}

- (void)initSubView {
    [self.view addSubview:[self tableView]];
}

- (TWRefreshTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.refreshDelegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.layer.opacity = 0.0f;
    }
    return _tableView;
}

- (void)setHomeData:(WGHome *)homeData {
    _homeData = homeData;
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)setRefreshType:(TWRefreshType)refreshType {
    if ((refreshType & TWRefreshTypeTop) == TWRefreshTypeTop) {
        [_tableView setRefreshHeaderEnabled:YES];
    }
    if ((refreshType & TWRefreshTypeBottom) == TWRefreshTypeBottom) {
        [_tableView setRefreshFooterEnabled:YES];
    }
}

- (void)handleFloorContentItem:(long long)id name:(NSString *)name jumpType:(WGAppJumpType)jumpType {
    if (jumpType == WGAppJumpTypeRegister) {
        WGRegisterViewController *vc = [[WGRegisterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (jumpType == WGAppJumpTypeInvitation) {
        WGInvitationViewController *vc = [[WGInvitationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (jumpType == WGAppJumpTypeGoodDetail) {
        WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
        vc.goodId = id;
        vc.title = name;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (jumpType == WGAppJumpTypeClassifyDetail) {
        WGClassifyDetailViewController *vc = [[WGClassifyDetailViewController alloc] init];
        vc.classifyId = id;
        vc.title = name;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (jumpType == WGAppJumpTypeSpecailClassifyHomeTab) {
        WGApplication *application = [WGApplication sharedApplication];
        WGHomeTabViewController *homeViewController = application.homeTabViewController;
        homeViewController.currentId = id;
        [application switchTab:WGTabIndexHome];
    }
    else if (jumpType == WGAppJumpTypeSpecailClassifyGoodBenefitTab) {
        WGApplication *application = [WGApplication sharedApplication];
        WGTabBenefitViewController *benefitViewController = application.benefitTabViewController;
        benefitViewController.currentId = id;
        [application switchTab:WGTabIndexBenefit];
    }
    else if (jumpType == WGAppJumpTypeSpecailClassifyNoTab) {
        WGSpecialClassifyViewController *vc = [[WGSpecialClassifyViewController alloc] init];
        vc.id = id;
        vc.title = name;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (jumpType == WGAppJumpTypeSpecailClassifyGoodNoTab) {
        WGSpecialClassifyGoodViewController *vc = [[WGSpecialClassifyGoodViewController alloc] init];
        vc.id = id;
        vc.title = name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)handleCarouselFigures:(NSInteger)index {
    WGCarouselFigureItem *item = _homeData.carouselFigures[index];
    if (item) {
        [self handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGHomeTabContentViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger number = 0;
    if (_homeData) {
        number = ((_homeData.floors) ? _homeData.floors.count : 0) + 1;
    }
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if (_homeData) {
        if (section == 0) {
            number = 3;
        }
        else {
            NSArray *floors = _homeData.floors;
            WGHomeFloorItem *floorItem = nil;
            if (floors.count > section - 1) {
                floorItem = floors[section - 1];
                number = floorItem.homeRowCount;
            }
        }
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = [WGHomeCarouselFiguresCell heightWithData:_homeData.carouselFigures];
        }
        else if (indexPath.row == 1) {
            height = _homeData.homeTopicsHeight;
        }
        else if (indexPath.row == 2) {
            height = _homeData.homeNewsHeight;
        }
    }
    else {
        NSArray *floors = _homeData.floors;
        WGHomeFloorItem *floorItem = nil;
        if (floors.count > indexPath.section - 1) {
            floorItem = floors[indexPath.section - 1];
            height = [floorItem heightOfContentItemOfRow:indexPath.row];
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    else {
        if ([tableView numberOfSections] == section + 1) {
            return kAppAdaptHeight(10);
        }
        return kAppAdaptHeight(8);
    }
}

- (NSString *)tableViewCellIdentifier:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    if (indexPath.section == 0) {
        identifier = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
    }
    else {
        if (indexPath.row == 0 || indexPath.row == 1) {
            identifier = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
        }
        else {
            NSInteger index = indexPath.section - 1;
            if (_homeData.floors.count > index) {
                WGHomeFloorItem *item = _homeData.floors[index];
                if (item.type == WGHomeFloorItemTypeGoodList &&
                    item.contents.count <= indexPath.row - 2) {
                    identifier = [NSString stringWithFormat:@"type_%ld_more", item.type];
                }
                else {
                    identifier = [NSString stringWithFormat:@"type_%ld", item.type];
                }
            }
        }
    }
    return [NSString stringWithFormat:@"cell_%@", identifier];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [self tableViewCellIdentifier:indexPath];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    ;
    if (!cell) {
        if (indexPath.section == 0) {
            WeakSelf;
            if (indexPath.row == 0) {
                WGHomeCarouselFiguresCell *carouselFiguresCell = [[WGHomeCarouselFiguresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                carouselFiguresCell.onApply = ^(NSInteger index) {
                    [weakSelf handleCarouselFigures:index];
                };
                cell = carouselFiguresCell;
            }
            else if (indexPath.row == 1) {
                WGHomeTopicCell *topCell = [[WGHomeTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                topCell.onApply = ^(WGTopicItem *item) {
                    [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                };
                cell = topCell;
            }
            else {
                cell = [[WGHomeNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
        }
        else {
            WGHomeFloorItem *item = _homeData.floors[indexPath.section - 1];
            if (indexPath.row == 0) {
                cell = [[WGHomeFloorNameAndBriefInfoHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (indexPath.row == 1) {
                cell = [[WGHomeFloorPictureHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else {
                WeakSelf;
                if (item.type == WGHomeFloorItemTypeCountry) {
                    WGHomeFloorCountryCell *countryCell = [[WGHomeFloorCountryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    countryCell.onApply = ^(WGHomeFloorContentItem *item) {
                        [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                    };
                    cell = countryCell;
                }
                else if (item.type == WGHomeFloorItemTypeGoodList) {
                    cell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
                    line.backgroundColor = WGAppSeparateLineColor;
                    [cell.contentView addSubview:line];
                }
                else if (item.type == WGHomeFloorItemTypeGoodColumn) {
                    WGHomeFloorGoodColumnCell *goodColumnCell = [[WGHomeFloorGoodColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    goodColumnCell.onApply = ^(WGHomeFloorContentItem *item) {
                        [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                    };
                    cell = goodColumnCell;
                }
                else if (item.type == WGHomeFloorItemTypeGoodGrid) {
                    WGHomeFloorGoodGridItemCell *goodGridCell = [[WGHomeFloorGoodGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    goodGridCell.onApply = ^(WGHomeFloorContentItem *item) {
                        [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                    };
                    cell = goodGridCell;
                }
                else if (item.type == WGHomeFloorItemTypeClassifyList) {
                    cell = [[WGHomeFloorClassifyListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeClassifyColumn) {
                    WGHomeFloorClassifyColumnCell *classifyColumnCell = [[WGHomeFloorClassifyColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    classifyColumnCell.onApply = ^(WGHomeFloorContentItem *item) {
                        [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                    };
                    cell = classifyColumnCell;
                }
                else if (item.type == WGHomeFloorItemTypeClassifyGrid) {
                    WGHomeFloorClassifyGridItemCell *classifyGridCell = [[WGHomeFloorClassifyGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    classifyGridCell.onApply = ^(WGHomeFloorContentItem *item) {
                        [weakSelf handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
                    };
                    cell = classifyGridCell;
                }
            }
        }
        if (!cell) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell showWithArray:_homeData.carouselFiguresPictureArray];
        }
        else if (indexPath.row == 1) {
            [cell showWithArray:_homeData.topics];
        }
        else {
            [cell showWithData:_homeData.news];
        }
    }
    else {
        WGHomeFloorItem *item = _homeData.floors[indexPath.section - 1];
        if (indexPath.row == 0 || indexPath.row == 1) {
            [cell showWithData:item];
        }
        else {
            NSInteger contentIndex = indexPath.row - 2;
            NSInteger contentCount = item.contents.count;
            if (item.type == WGHomeFloorItemTypeGoodList ||
                item.type == WGHomeFloorItemTypeClassifyList) {
                if (contentCount > contentIndex) {
                    WGHomeFloorContentItem *content = item.contents[contentIndex];
                    [cell showWithData:[content contentItemWithType:item.type]];
                }
            }
            else {
                NSRange range = NSMakeRange(0, 0);
                if (item.type == WGHomeFloorItemTypeCountry ||
                    item.type == WGHomeFloorItemTypeClassifyGrid) {
                    NSUInteger loc = contentIndex * 4;
                    range = NSMakeRange(loc, (((contentCount - loc) / 4) > 0) ? 4 : ((contentCount - loc) % 4));
                }
                else if (item.type == WGHomeFloorItemTypeGoodGrid) {
                    NSUInteger loc = contentIndex * 2;
                    range = NSMakeRange(loc, (((contentCount - loc) / 2) > 0) ? 2 : ((contentCount - loc) % 2));
                }
                else if (item.type == WGHomeFloorItemTypeGoodColumn ||
                         item.type == WGHomeFloorItemTypeClassifyColumn) {
                    range = NSMakeRange(0, item.contents.count);
                }
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
                NSArray *dataArray = [item.contents objectsAtIndexes:set];
                [cell showWithArray:dataArray];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section != 0) {
        NSArray *floors = _homeData.floors;
        WGHomeFloorItem *item = floors[section - 1];
        if (row == 0 || row == 1) {
            [self handleFloorContentItem:item.id name:item.name jumpType:item.jumpType];
        }
        else {
            JHTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            if ([cell isKindOfClass:[WGHomeFloorGoodListItemCell class]] || [cell isKindOfClass:[WGHomeFloorClassifyListItemCell class]]) {
                WGHomeFloorContentItem *subItem = item.contents[row - 2];
                [self handleFloorContentItem:subItem.id name:subItem.name jumpType:subItem.jumpType];
            }
        }
    }
//    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
//    vc.goodId = 1591;
//    [self.navigationController pushViewController:vc animated:YES];
//    WGShopCartViewController *vc = [[WGShopCartViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    WGSearchViewController *vc = [[WGSearchViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    WGInvitationViewController *vc = [[WGInvitationViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    WGCommitOrderViewController *vc = [[WGCommitOrderViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    WGMessageCenterViewController *vc = [[WGMessageCenterViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    WGOrderListViewController *vc = [[WGOrderListViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    WGOrderDetailViewController *vc = [[WGOrderDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    /*
    WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
    /*
    WGClientServiceCenterViewController *vc = [[WGClientServiceCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
    /*
    WGBindThirdPartyViewController *vc = [[WGBindThirdPartyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
    /*
    WGLoginViewController *vc = [[WGLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
//    WGHomeTabContentViewController *vc = [[WGHomeTabContentViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    /*
    WGClassifyDetailViewController *vc = [[WGClassifyDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    */
     /*
    WGShopCartViewController *vc = [[WGShopCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
    
//    WGCouponListViewController *vc = [[WGCouponListViewController alloc] init];
//    vc.isSelect = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    WGAddressListViewController *vc = [[WGAddressListViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    /*
    WGReceiptListViewController *vc = [[WGReceiptListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    */
     /*
    WGClassifyGoodListViewController *vc = [[WGClassifyGoodListViewController alloc] init];
    vc.classifyName = @"Fruit";
    [self.navigationController pushViewController:vc animated:YES];
     */
}

- (void)beginRefreshHeader:(TWRefreshTableView*) tableView {
    if (self.onTopRefresh) {
        self.onTopRefresh();
    }
}

- (void)beginRefreshFooter:(TWRefreshTableView*) tableView {

}

@end

