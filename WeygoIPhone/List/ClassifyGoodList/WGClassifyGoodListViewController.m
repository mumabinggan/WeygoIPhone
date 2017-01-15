//
//  WGClassifyGoodListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyGoodListViewController.h"
#import "WGClassifyGoodListContentItem.h"
#import "WGHomeFloorGoodListItemCell.h"

@interface WGClassifyGoodListViewController ()
{
    TWRefreshTableView  *_tableView;
    JHImageView         *_classifyImageView;
}
@end

@interface WGClassifyGoodListViewController (TableViewDelegate)<UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGClassifyGoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    WGClassifyGoodList *data = [[WGClassifyGoodList alloc] init];
    data.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    data.classifyName = @"zheng";
    
    WGClassifyGoodListContentItem *classifyItem = [[WGClassifyGoodListContentItem alloc] init];
    classifyItem.classifyName = @"zheng";
    
    WGHomeFloorContentGoodItem *goodItem1 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem1.name = @"qian";
    goodItem1.chineseName = @"郑渊谦";
    goodItem1.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem1.price = 12.3;
    goodItem1.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem1.discount = 0.3;
    goodItem1.reducePrice = 2.3;
    goodItem1.currentPrice = 10.1;
    
    WGHomeFloorContentGoodItem *goodItem2 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem2.name = @"zhengyuanqian";
    goodItem2.chineseName = @"郑渊谦";
    goodItem2.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem2.price = 12.3;
    goodItem2.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem2.discount = 0.3;
    goodItem2.reducePrice = 2.3;
    goodItem2.currentPrice = 10.1;
    
    WGHomeFloorContentGoodItem *goodItem3 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem3.name = @"zhengyuan";
    goodItem3.chineseName = @"郑渊谦";
    goodItem3.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem3.price = 12.3;
    goodItem3.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem3.discount = 0.3;
    goodItem3.reducePrice = 2.3;
    goodItem3.currentPrice = 10.1;
    
    classifyItem.contents = @[goodItem1, goodItem2, goodItem3];
    
    
    WGClassifyGoodListContentItem *classifyItem2 = [[WGClassifyGoodListContentItem alloc] init];
    classifyItem2.classifyName = @"zhengyuanqian";
    
    WGHomeFloorContentGoodItem *goodItem4 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem4.name = @"zhengyuanqian";
    goodItem4.chineseName = @"郑渊谦";
    goodItem4.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem4.price = 12.3;
    goodItem4.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem4.discount = 0.3;
    goodItem4.reducePrice = 2.3;
    goodItem4.currentPrice = 10.1;
    
    classifyItem2.contents = @[goodItem4];
    
    
    WGClassifyGoodListContentItem *classifyItem3 = [[WGClassifyGoodListContentItem alloc] init];
    classifyItem3.classifyName = @"faskldfkasdlfas";
    
    WGHomeFloorContentGoodItem *goodItem5 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem5.name = @"WKZF";
    goodItem5.chineseName = @"郑渊谦";
    goodItem5.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem5.price = 12.3;
    goodItem5.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem5.discount = 0.3;
    goodItem5.reducePrice = 2.3;
    goodItem5.currentPrice = 10.1;
    
    WGHomeFloorContentGoodItem *goodItem6 = [[WGHomeFloorContentGoodItem alloc] init];
    goodItem6.name = @"WKZFFJS,F";
    goodItem6.chineseName = @"郑渊谦";
    goodItem6.briefDescription = @"fdfasdfasdfasdf asfdaad";
    goodItem6.price = 12.3;
    goodItem6.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091606.jpg";
    goodItem6.discount = 0.3;
    goodItem6.reducePrice = 2.3;
    goodItem6.currentPrice = 10.1;
    
    classifyItem3.contents = @[goodItem5, goodItem6];
    
    data.contents = @[classifyItem, classifyItem2, classifyItem3];
    _data = data;
}

- (void)initSubView {
    self.title = _classifyName;
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeTop];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.tableHeaderView = [self classifyImageView];
    [self.view addSubview:_tableView];
}

- (JHImageView *)classifyImageView {
    if (!_classifyImageView) {
        _classifyImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(176))];
        [_classifyImageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kClassifyGoodListClassifyPlaceholderImage options:JHWebImageOptionsRefreshCached];
    }
    return _classifyImageView;
}

- (void)refreshTableView {
    [_classifyImageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kClassifyGoodListClassifyPlaceholderImage options:JHWebImageOptionsRefreshCached];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGClassifyGoodListViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_data && _data.contents) ? _data.contents.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_data && _data.contents.count > section) {
        WGClassifyGoodListContentItem *item = (WGClassifyGoodListContentItem *)_data.contents[section];
        return (item && item.contents) ? item.contents.count : 0;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    if (_data && _data.contents && _data.contents.count > section) {
        WGClassifyGoodListContentItem *classifyItem = _data.contents[section];
        title = classifyItem.classifyName;
    }
    return title;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JHView *view = [[JHView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    JHLabel *nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(40))];
    nameLabel.font = kAppAdaptFont(14);
    nameLabel.textColor = WGAppNameLabelColor;
    NSString *title = nil;
    if (_data && _data.contents && _data.contents.count > section) {
        WGClassifyGoodListContentItem *classifyItem = _data.contents[section];
        title = classifyItem.classifyName;
    }
    nameLabel.text = title;
    [view addSubview:nameLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kAppAdaptHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(124);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WGHomeFloorGoodListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (_data && _data.contents && _data.contents.count > indexPath.section) {
        WGClassifyGoodListContentItem *classifyItem = _data.contents[indexPath.section];
        if (classifyItem && classifyItem.contents && classifyItem.contents.count > indexPath.row) {
            WGHomeFloorContentGoodItem *goodItem = classifyItem.contents[indexPath.row];
            [cell showWithData:goodItem];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)beginRefreshFooter:(TWRefreshTableView*) tableView {
    
}

@end
