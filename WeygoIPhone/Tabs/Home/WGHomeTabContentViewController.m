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

//for test
#import "WGClassifyGoodListViewController.h"
#import "WGReceiptListViewController.h"
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
    [self loadHomeTabTitles];
}

- (void)initData {
    _homeData = [[WGHome alloc] init];
    
    //carouselFigureArray
    WGCarouselFigureItem *carouselFigureItem = [[WGCarouselFigureItem alloc] init];
    carouselFigureItem.pictureURL = @"http://www.pp3.cn/uploads/201610/2016100805.jpg";
    
    WGCarouselFigureItem *carouselFigureItem1 = [[WGCarouselFigureItem alloc] init];
    carouselFigureItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016090809.jpg";
    _homeData.carouselFigures = @[carouselFigureItem, carouselFigureItem1];
    
    //WGTopicItem
    WGTopicItem *topicItem = [[WGTopicItem alloc] init];
    topicItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016090910.jpg";
    topicItem.name = @"zheng";
    WGTopicItem *topicItem1 = [[WGTopicItem alloc] init];
    topicItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    topicItem1.name = @"zhengyuan";
    WGTopicItem *topicItem2 = [[WGTopicItem alloc] init];
    topicItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    topicItem2.name = @"zhengyuanqian";
    WGTopicItem *topicItem3 = [[WGTopicItem alloc] init];
    topicItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    topicItem3.name = @"zhengyuanqian haha";
    _homeData.topics = @[topicItem, topicItem1, topicItem2, topicItem3];;
    
    //New
    WGNewsItem *newItem1 = [[WGNewsItem alloc] init];
    newItem1.name = @"How do you return a multiline text CGSize from the new iOS 7 method sizeW";
    WGNewsItem *newItem2 = [[WGNewsItem alloc] init];
    newItem2.name = @"CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName : [UIFon";
    WGNewsItem *newItem3 = [[WGNewsItem alloc] init];
    newItem3.name = @"or the first time i see this notation for di";
    WGNewsItem *newItem4 = [[WGNewsItem alloc] init];
    newItem4.name = @"Have a look at this: stackoverflow.com/question";
    WGNews *news = [[WGNews alloc] init];
    news.name = @"好消息";
    news.contents = @[newItem1, newItem2, newItem3, newItem4];
    _homeData.news = news;
    
    WGHomeFloorItem *floor = [[WGHomeFloorItem alloc] init];
    floor.type = WGHomeFloorItemTypeGoodList;
    floor.name = @"郑渊谦";
    floor.breifDescription = @"IOS 开发工程师";
    floor.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem = [[WGHomeFloorContentItem alloc] init];
    floorItem.type = WGHomeFloorItemTypeGoodList;
    floorItem.name = @"zhengyuanqian";
    floorItem.chineseName = @"郑渊谦";
    floorItem.briefDescription = @"fdfasdfasdfasdf asfdaad";
    floorItem.price = 12.3;
    floorItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem.discount = 0.3;
    floorItem.reducePrice = 2.3;
    floorItem.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem1 = [[WGHomeFloorContentItem alloc] init];
    floorItem1.type = WGHomeFloorItemTypeGoodList;
    floorItem1.name = @"zhengyuanqian";
    floorItem1.chineseName = @"渊谦";
    floorItem1.briefDescription = @"fdfasdfasdfasdf";
    floorItem1.price = 12.3;
    floorItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem1.discount = 0.3;
    floorItem1.reducePrice = 2.3;
    floorItem1.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem2 = [[WGHomeFloorContentItem alloc] init];
    floorItem2.type = WGHomeFloorItemTypeGoodList;
    floorItem2.name = @"zhengyuanqian";
    floorItem2.chineseName = @"郑谦";
    floorItem2.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem2.price = 12.3;
    floorItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem2.discount = 0.3;
    floorItem2.reducePrice = 2.3;
    floorItem2.currentPrice = 10.1;
    floor.contents = @[floorItem, floorItem1, floorItem2];
    
    WGHomeFloorItem *floor1 = [[WGHomeFloorItem alloc] init];
    floor1.type = WGHomeFloorItemTypeGoodColumn;
    floor1.name = @"郑渊谦";
    floor1.breifDescription = @"IOS 开发工程师";
    floor1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem3 = [[WGHomeFloorContentItem alloc] init];
    floorItem3.type = WGHomeFloorItemTypeGoodColumn;
    floorItem3.name = @"zhengyuanqian";
    floorItem3.chineseName = @"郑渊谦";
    floorItem3.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem3.price = 12.3;
    floorItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem3.discount = 0.3;
    floorItem3.reducePrice = 2.3;
    floorItem3.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem4 = [[WGHomeFloorContentItem alloc] init];
    floorItem4.type = WGHomeFloorItemTypeGoodColumn;
    floorItem4.name = @"zhengyuanqian";
    floorItem4.chineseName = @"渊谦";
    floorItem4.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem4.price = 12.3;
    floorItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem4.discount = 0.3;
    floorItem4.reducePrice = 2.3;
    floorItem4.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem5 = [[WGHomeFloorContentItem alloc] init];
    floorItem5.type = WGHomeFloorItemTypeGoodColumn;
    floorItem5.name = @"zhengyuanqian";
    floorItem5.chineseName = @"郑谦";
    floorItem5.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem5.price = 12.3;
    floorItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem5.discount = 0.3;
    floorItem5.reducePrice = 2.3;
    floorItem5.currentPrice = 10.1;
    floor1.contents = @[floorItem3, floorItem4, floorItem5];
    
    WGHomeFloorItem *floor2 = [[WGHomeFloorItem alloc] init];
    floor2.type = WGHomeFloorItemTypeGoodGrid;
    floor2.name = @"郑渊谦";
    floor2.breifDescription = @"IOS 开发工程师";
    floor2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem6 = [[WGHomeFloorContentItem alloc] init];
    floorItem6.type = WGHomeFloorItemTypeGoodGrid;
    floorItem6.name = @"zhengyuanqian";
    floorItem6.chineseName = @"郑渊谦";
    floorItem6.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem6.price = 12.3;
    floorItem6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem6.discount = 0.3;
    floorItem6.reducePrice = 2.3;
    floorItem6.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem7 = [[WGHomeFloorContentItem alloc] init];
    floorItem7.type = WGHomeFloorItemTypeGoodGrid;
    floorItem7.name = @"zhengyuanqian";
    floorItem7.chineseName = @"渊谦";
    floorItem7.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem7.price = 12.3;
    floorItem7.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem7.discount = 0.3;
    floorItem7.reducePrice = 2.3;
    floorItem7.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem8 = [[WGHomeFloorContentItem alloc] init];
    floorItem8.type = WGHomeFloorItemTypeGoodGrid;
    floorItem8.name = @"zhengyuanqian";
    floorItem8.chineseName = @"郑谦";
    floorItem8.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem8.price = 12.3;
    floorItem8.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem8.discount = 0.3;
    floorItem8.reducePrice = 2.3;
    floorItem8.currentPrice = 10.1;
    floor2.contents = @[floorItem6, floorItem7, floorItem8];
    
    WGHomeFloorItem *floor3 = [[WGHomeFloorItem alloc] init];
    floor3.type = WGHomeFloorItemTypeCountry;
    floor3.name = @"郑渊谦";
    floor3.breifDescription = @"IOS 开发工程师";
    floor3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem9 = [[WGHomeFloorContentItem alloc] init];
    floorItem9.type = WGHomeFloorItemTypeCountry;
    floorItem9.name = @"zhengyuanqian";
    floorItem9.chineseName = @"郑谦";
    floorItem9.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem9.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor3.contents = @[floorItem9];
    
    WGHomeFloorItem *floor4 = [[WGHomeFloorItem alloc] init];
    floor4.type = WGHomeFloorItemTypeClassifyList;
    floor4.name = @"郑渊谦";
    floor4.breifDescription = @"IOS 开发工程师";
    floor4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem10 = [[WGHomeFloorContentItem alloc] init];
    floorItem10.type = WGHomeFloorItemTypeClassifyList;
    floorItem10.name = @"zhengyuanqian";
    floorItem10.chineseName = @"郑谦";
    floorItem10.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem10.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor4.contents = @[floorItem10];
    
    WGHomeFloorItem *floor5 = [[WGHomeFloorItem alloc] init];
    floor5.type = WGHomeFloorItemTypeClassifyColumn;
    floor5.name = @"郑渊谦";
    floor5.breifDescription = @"IOS 开发工程师";
    floor5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem11 = [[WGHomeFloorContentItem alloc] init];
    floorItem11.type = WGHomeFloorItemTypeClassifyColumn;
    floorItem11.name = @"zhengyuanqian";
    floorItem11.chineseName = @"郑谦";
    floorItem11.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem11.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor5.contents = @[floorItem11];
    
    WGHomeFloorItem *floor6 = [[WGHomeFloorItem alloc] init];
    floor6.type = WGHomeFloorItemTypeClassifyGrid;
    floor6.name = @"郑渊谦";
    floor6.breifDescription = @"IOS 开发工程师";
    floor6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    WGHomeFloorContentItem *floorItem12 = [[WGHomeFloorContentItem alloc] init];
    floorItem12.type = WGHomeFloorItemTypeClassifyGrid;
    floorItem12.name = @"zhengyuanqian";
    floorItem12.chineseName = @"郑谦";
    floorItem12.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem12.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor6.contents = @[floorItem12];
    
    _homeData.floors = @[floor, floor1, floor2, floor3, floor4, floor5, floor6];
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
    }
    return _tableView;
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
    if (!cell) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell = [[WGHomeCarouselFiguresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else if (indexPath.row == 1) {
                cell = [[WGHomeTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            else {
                cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
                if (item.type == WGHomeFloorItemTypeCountry) {
                    cell = [[WGHomeFloorCountryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeGoodList) {
                    cell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
                    line.backgroundColor = WGAppSeparateLineColor;
                    [cell.contentView addSubview:line];
                }
                else if (item.type == WGHomeFloorItemTypeGoodColumn) {
                    cell = [[WGHomeFloorGoodColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeGoodGrid) {
                    cell = [[WGHomeFloorGoodGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeClassifyList) {
                    cell = [[WGHomeFloorClassifyListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeClassifyColumn) {
                    cell = [[WGHomeFloorClassifyColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                else if (item.type == WGHomeFloorItemTypeClassifyGrid) {
                    cell = [[WGHomeFloorClassifyGridItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
                    [cell showWithData:content.contentItem];
                }
            }
            else {
                NSRange range;
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
    WGMessageCenterViewController *vc = [[WGMessageCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    /*
    WGCouponListViewController *vc = [[WGCouponListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
     */
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

}

- (void)beginRefreshFooter:(TWRefreshTableView*) tableView {

}

@end

