//
//  WGHomeTabContentViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabContentViewController.h"
#import "WGHomeFloorItem.h"

//can delete
#import "WGCarouselFigureItem.h"
#import "WGTopicItem.h"
#import "WGNewsItem.h"
#import "WGHomeFloorItem.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeTabContentViewController ()

@end

@interface WGHomeTabContentViewController (CollectionDelegate)<UICollectionViewDataSource, UICollectionViewDelegate, TWCollectionViewRefreshingDelegate>

@end

@interface WGHomeTabContentViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGHomeTabContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self.view addSubview:[self tableView]];
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
    WGTopicItem *topic = [[WGTopicItem alloc] init];
    topic.pictureURL = @"http://www.pp3.cn/uploads/201609/2016090910.jpg";
    WGTopicItem *topic1 = [[WGTopicItem alloc] init];
    topic.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    WGTopicItem *topic2 = [[WGTopicItem alloc] init];
    topic.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    WGTopicItem *topic3 = [[WGTopicItem alloc] init];
    topic.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    _homeData.topics = @[topic, topic1, topic2, topic3];
    
    //New
    WGNewsItem *new1 = [[WGNewsItem alloc] init];
    new1.name = @"[言阙]:送别的我要骂人的。";
    WGNewsItem *new2 = [[WGNewsItem alloc] init];
    new2.name = @"动物分类学家根据动物的各种特征。";
    WGNewsItem *new3 = [[WGNewsItem alloc] init];
    new3.name = @"中国,国情,野生动物,濒危野生动物。";
    WGNewsItem *new4 = [[WGNewsItem alloc] init];
    new4.name = @"狮子和鬣狗天生就是对手。";
    _homeData.news = @[new1, new2, new3, new4];
    
    WGHomeFloorItem *floor = [[WGHomeFloorItem alloc] init];
    floor.type = WGHomeFloorItemTypeGoodList;
    floor.name = @"郑渊谦";
    floor.breifDescription = @"IOS 开发工程师";
    floor.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    
    WGHomeFloorContentItem *floorItem = [[WGHomeFloorContentItem alloc] init];
    floorItem.name = @"zhengyuanqian";
    floorItem.chineseName = @"郑渊谦";
    floorItem.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem.price = 12.3;
    floorItem.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem.discount = 0.3;
    floorItem.reducePrice = 2.3;
    floorItem.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem1 = [[WGHomeFloorContentItem alloc] init];
    floorItem1.name = @"zhengyuanqian";
    floorItem1.chineseName = @"渊谦";
    floorItem1.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem1.price = 12.3;
    floorItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem1.discount = 0.3;
    floorItem1.reducePrice = 2.3;
    floorItem1.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem2 = [[WGHomeFloorContentItem alloc] init];
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
    floorItem3.name = @"zhengyuanqian";
    floorItem3.chineseName = @"郑渊谦";
    floorItem3.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem3.price = 12.3;
    floorItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem3.discount = 0.3;
    floorItem3.reducePrice = 2.3;
    floorItem3.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem4 = [[WGHomeFloorContentItem alloc] init];
    floorItem4.name = @"zhengyuanqian";
    floorItem4.chineseName = @"渊谦";
    floorItem4.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem4.price = 12.3;
    floorItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem4.discount = 0.3;
    floorItem4.reducePrice = 2.3;
    floorItem4.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem5 = [[WGHomeFloorContentItem alloc] init];
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
    floorItem6.name = @"zhengyuanqian";
    floorItem6.chineseName = @"郑渊谦";
    floorItem6.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem6.price = 12.3;
    floorItem6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem6.discount = 0.3;
    floorItem6.reducePrice = 2.3;
    floorItem6.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem7 = [[WGHomeFloorContentItem alloc] init];
    floorItem7.name = @"zhengyuanqian";
    floorItem7.chineseName = @"渊谦";
    floorItem7.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem7.price = 12.3;
    floorItem7.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floorItem7.discount = 0.3;
    floorItem7.reducePrice = 2.3;
    floorItem7.currentPrice = 10.1;
    
    WGHomeFloorContentItem *floorItem8 = [[WGHomeFloorContentItem alloc] init];
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
    floorItem12.name = @"zhengyuanqian";
    floorItem12.chineseName = @"郑谦";
    floorItem12.briefDescription = @"天生性情温驯，毛色有纯色、";
    floorItem12.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    floor6.contents = @[floorItem12];
    
    _homeData.floors = @[floor, floor1, floor2, floor3, floor4, floor5, floor6];
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

- (TWRefreshCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(100, 100);
        layout.footerReferenceSize = CGSizeMake(kDeviceWidth, 50);
        _collectionView = [[TWRefreshCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        _collectionView = [[TWRefreshCollectionView alloc]initWithFrame:_contentsScrollView.bounds collectionViewLayout:layout refreshType:TWRefreshTypeTop | TWRefreshTypeBottom];
        //_collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //_collectionView.refreshDelegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _collectionView;
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
            height = _homeData.homeCarouselFiguresHeight;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        cell.backgroundColor = kRedColor;
    }
    else if (indexPath.row == 1) {
        cell.backgroundColor = kGreenColor;
    }
    else if (indexPath.row == 2) {
        cell.backgroundColor = kBlueColor;
    }
    else if (indexPath.row == 3) {
        cell.backgroundColor = kGrayColor;
    }
    else if (indexPath.row == 4) {
        cell.backgroundColor = kYellowColor;
    }
    else if (indexPath.row == 5) {
        cell.backgroundColor = kRandomColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)beginRefreshHeader:(TWRefreshTableView*) tableView {

}

- (void)beginRefreshFooter:(TWRefreshTableView*) tableView {

}

@end

@implementation WGHomeTabContentViewController (CollectionDelegate)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger number = 0;
    if (_homeData) {
        number = ((_homeData.floors) ? _homeData.floors.count : 0) + 1;
    }
    return number;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger number = 0;
    if (_homeData) {
        if (section == 0) {
            number = (_homeData.carouselFigures == nil || _homeData.carouselFigures.count == 0) ? 0 : 1;
            number = (_homeData.topics == nil || _homeData.topics.count == 0) ? 0 : 1;
            number = (_homeData.news == nil || _homeData.news.count == 0) ? 0 : 1;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)beginRefreshHeader:(TWRefreshCollectionView*) collectionView {
    DLog(@"---header collection");
}

- (void)beginRefreshFooter:(TWRefreshCollectionView*) collectionView {
    DLog(@"---footer collection");
}

@end
