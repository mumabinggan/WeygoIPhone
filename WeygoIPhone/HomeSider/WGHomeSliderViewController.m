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

@interface WGHomeSliderViewController ()
{
    JHTableView *_tableView;
    NSInteger _selectedSection;    //default = -1;
}
@end

@interface WGHomeSliderViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGHomeSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _data = [[WGHomeSlider alloc] init];
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
    _data.topics = @[topicItem, topicItem1, topicItem2, topicItem3];
    
    WGClassifyItem *item = [[WGClassifyItem alloc] init];
    item.name = @"zhenguasdf";
    item.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    item.subArray = [self getSubArray:20];
    
    WGClassifyItem *item2 = [[WGClassifyItem alloc] init];
    item2.name = @"uasdf";
    item2.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073408_255.jpg";
    item2.subArray = [self getSubArray:5];
    
    WGClassifyItem *item3 = [[WGClassifyItem alloc] init];
    item3.name = @"fsuasdf";
    item3.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073436_260.jpg";
    item3.subArray = [self getSubArray:10];
    
    WGClassifyItem *item4 = [[WGClassifyItem alloc] init];
    item4.name = @"asfsdazhenguasdf";
    item4.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073440_93.jpg";
    item4.subArray = [self getSubArray:1];
    
    WGClassifyItem *item5 = [[WGClassifyItem alloc] init];
    item5.name = @"zfjdhenguasdf";
    item5.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item5.subArray = [self getSubArray:7];
    
    WGClassifyItem *item6 = [[WGClassifyItem alloc] init];
    item6.name = @"zfjdhenguasdf";
    item6.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item6.subArray = [self getSubArray:7];
    
    _data.classifys = @[item, item2, item3, item4, item5, item6];
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
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
}

- (void)touchBlankArea:(id)sender {
    if (self.onTouchBlankArea) {
        self.onTouchBlankArea();
    }
}

- (void)handleOnApplyHeaderView:(WGClassifyItem *)classify section:(NSInteger)section {
    _selectedSection = (section == _selectedSection) ? -1 : section;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGHomeSliderViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ((_data == nil) ? 0 : _data.classifys.count) + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else if (section == 1) {
        return (_data.topics.count + 1)/2;
    }
    else {
        WGClassifyItem *item = _data.classifys[section - 2];
        return (_selectedSection > 1) ? item.subArray.count : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 0.0;
    }
    else {
        return kAppAdaptHeight(48);
    }
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
        height = kAppAdaptHeight(72);
    }
    else if (indexPath.section == 2) {
        height = kAppAdaptHeight(40);
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return nil;
    }
    static NSString *headerId = @"headerId";
    JHTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headerView) {
        __weak id weakSelf = self;
        WGHomeSliderClassifyHeaderView *view = [[WGHomeSliderClassifyHeaderView alloc] initWithReuseIdentifier:headerId];
        view.onApply = ^(WGClassifyItem *item) {
            [weakSelf handleOnApplyHeaderView:item section:section];
        };
        headerView = view;
    }
    WGHomeSliderClassifyItem *item = (_data.classifys[section - 2]);
    //item.selected = (_selectedSection == section);
    [headerView showWithData:item];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    cellId = [NSString stringWithFormat:@"cellId_%ld", indexPath.section];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (indexPath.section == 1) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.textColor = WGAppNameLabelColor;
        }
        else if (indexPath.section == 1) {
            cell = [[WGSliderTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        else {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.textColor = WGAppTitleColor;
        }
    }
    
    if (indexPath.section != 0) {
        if (indexPath.section == 0) {
            
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
            NSInteger index = indexPath.section - 2;
            WGClassifyItem *item = _data.classifys[index];
            NSArray *subArray = item.subArray;
            [cell showWithData:subArray[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1) {
        
        }
        else if (indexPath.row == 2) {
            
        }
        else if (indexPath.row == 3) {
            
        }
        else if (indexPath.row == 4) {
            
        }
    }
    if (indexPath.section == 2) {
        
    }
}

@end
