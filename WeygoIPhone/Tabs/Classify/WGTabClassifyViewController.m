//
//  WGClassifyTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabClassifyViewController.h"
#import "WGImageClassifyCell.h"
#import "WGClassifyHotSaleGoodCell.h"
#import "WGImageClassifyCell.h"
#import "WGTextClassifyCell.h"
#import "WGClassifyDetailViewController.h"
#import "WGGoodDetailViewController.h"
#import "WGTabClassifyViewController+Request.h"

//for test
#import "WGClassifyItem.h"
#import "WGClassifyHotGoodItem.h"

@interface WGTabClassifyViewController ()
{
    JHTableView *_firstTableView;
    JHTableView *_secondTableView;
    JHImageView *_arrImageView;
    
    NSInteger _currentSelectedIndex;
    NSArray *_subArray;
    NSArray *_goodsArray;
}
@end

@interface WGTabClassifyViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGTabClassifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexClassify;
        self.tabBarItem.title = kStr(@"TabClassify");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_classify_icon"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadClassify];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadClassify];
    //[self setData];
}

- (void)initData {
    _currentSelectedIndex = 0;
}

- (void)setData {
    WGClassifyItem *item = [[WGClassifyItem alloc] init];
    item.name = @"zhenguasdf";
    item.pictureURL = @"http://www.pp3.cn/uploads/201609/2016091012.jpg";
    item.subArray = [self getSubArray:20];
    item.goodArray = [self getGoodArray:3];
    
    WGClassifyItem *item2 = [[WGClassifyItem alloc] init];
    item2.name = @"uasdf";
    item2.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073408_255.jpg";
    item2.subArray = [self getSubArray:5];
    item2.goodArray = [self getGoodArray:1];
    
    WGClassifyItem *item3 = [[WGClassifyItem alloc] init];
    item3.name = @"fsuasdf";
    item3.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073436_260.jpg";
    item3.subArray = [self getSubArray:10];
    item3.goodArray = [self getGoodArray:2];
    
    WGClassifyItem *item4 = [[WGClassifyItem alloc] init];
    item4.name = @"asfsdazhenguasdf";
    item4.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073440_93.jpg";
    item4.subArray = [self getSubArray:1];
    
    WGClassifyItem *item5 = [[WGClassifyItem alloc] init];
    item5.name = @"zfjdhenguasdf";
    item5.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item5.subArray = [self getSubArray:7];
    item5.goodArray = [self getGoodArray:2];
    
    WGClassifyItem *item6 = [[WGClassifyItem alloc] init];
    item6.name = @"zfjdhenguasdf";
    item6.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
    item6.subArray = [self getSubArray:7];
    item6.goodArray = [self getGoodArray:2];
    
    _data = @[item, item2, item3, item4, item5, item6];
    
    //_subArray = ((WGClassifyItem *)_data[_currentSelectedIndex]).allArray;
    [self refreshUI];
}

- (NSArray *)getGoodArray:(NSInteger)count {
    NSMutableArray *subMArray = [NSMutableArray array];
    for (int num = 0; num < count; ++num) {
        WGClassifyHotGoodItem *subItem = [[WGClassifyHotGoodItem alloc] init];
        subItem.name = [NSString stringWithFormat:@"name_%d", num];
        subItem.pictureURL = @"http://img1.touxiang.cn/uploads/20131203/03-073442_102.jpg";
        subItem.price = @"98.32";
        subItem.currentPrice = @"43.32";
        [subMArray addObject:subItem];
    }
    return subMArray;
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

- (void)refreshUI {
    [self setSubArray];
    [self setGoodArray];
    [_firstTableView reloadData];
    [_secondTableView reloadData];
    [UIView animateWithDuration:0.05 animations:^() {
        _firstTableView.layer.opacity = 1.0;
        _secondTableView.layer.opacity = 1.0;
    }];
    [_secondTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [UIView animateWithDuration:0.3 animations:^() {
        _arrImageView.y = _currentSelectedIndex * kAppAdaptHeight(98) + kAppAdaptHeight(49 - 3);
    }];
}

- (void)setSubArray {
    if (_data.count > _currentSelectedIndex) {
        WGClassifyItem *item = _data[_currentSelectedIndex];
        _subArray = item.allArray;
    }
    else {
        _subArray = nil;
    }
}

- (void)setGoodArray {
    if (_data.count > _currentSelectedIndex) {
        WGClassifyItem *item = _data[_currentSelectedIndex];
        _goodsArray = item.goodArray;
    }
    else {
        _goodsArray = nil;
    }
}

- (void)initSubView {
    self.title = kStr(@"TabClassify");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    
    _firstTableView = [[JHTableView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(160), self.view.height) style:UITableViewStyleGrouped];
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstTableView.contentInset = UIEdgeInsetsMake(0, 0, kAppTabBarHeight, 0);
    _firstTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:_firstTableView];
    
    _secondTableView = [[JHTableView alloc] initWithFrame:CGRectMake(_firstTableView.maxX, 0, kAppAdaptWidth(215), self.view.height)];
    _secondTableView.dataSource = self;
    _secondTableView.delegate = self;
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondTableView.contentInset = UIEdgeInsetsMake(0, 0, kAppTabBarHeight, 0);
    _secondTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:_secondTableView];
    
    _arrImageView = [[JHImageView alloc] initWithFrame:CGRectMake(_firstTableView.width - kAppAdaptWidth(6), _currentSelectedIndex * kAppAdaptHeight(98) + kAppAdaptHeight(49 - 3), kAppAdaptWidth(6), kAppAdaptHeight(12))];
    _arrImageView.image = [UIImage imageNamed:@"tab_classify_arr"];
    [_firstTableView addSubview:_arrImageView];
    
    _firstTableView.layer.opacity = 0.0;
    _secondTableView.layer.opacity = 0.0;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGTabClassifyViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:_secondTableView]) {
        if (_goodsArray.count) {
            return 3;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_firstTableView]) {
        return _data.count;
    }
    else {
        if (section == 0) {
            return _subArray.count;
        }
        else if (section == 1) {
            return 1;
        }
        else {
            return _goodsArray.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        return kAppAdaptHeight(98) + ((_data.count == indexPath.row + 1) ? kAppAdaptHeight(2) : 0);
    }
    else {
        if (indexPath.section == 0) {
            return kAppAdaptHeight(48);
        }
        else if (indexPath.section == 1) {
            return kAppAdaptHeight(40);
        }
        else {
            return kAppAdaptHeight(213);
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [NSString stringWithFormat:@"cellId_%d_%ld", ([tableView isEqual:_firstTableView]), indexPath.section];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if ([tableView isEqual:_firstTableView]) {
            cell = [[WGImageClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.clipsToBounds = YES;
        }
        else {
            if (indexPath.section == 0) {
                cell = [[WGTextClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
                line.backgroundColor = WGAppSeparateLineColor;
                line.tag = 999;
                [cell.contentView addSubview:line];
            }
            else if (indexPath.section == 1) {
                cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.textLabel.text = kStr(@"Hot Sale");
                cell.textLabel.font = kAppAdaptFontBold(14);
                cell.backgroundColor = kHRGB(0xf8fafa);
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
            else {
                cell = [[WGClassifyHotSaleGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.backgroundColor = kHRGB(0xF8FAFA);
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([tableView isEqual:_firstTableView]) {
        [cell showWithData:_data[indexPath.row]];
    }
    else {
        if (indexPath.section == 0) {
            [cell showWithData:_subArray[indexPath.row]];
            JHView *line = [cell.contentView viewWithTag:999];
            line.hidden = (_goodsArray.count > 0) && (indexPath.row + 1 == _subArray.count);
        }
        else if (indexPath.section == 2) {
            WGClassifyHotSaleGoodCell *hotSaleCell = (WGClassifyHotSaleGoodCell *)cell;
            hotSaleCell.hotNumberImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hotsale_icon_%ld", indexPath.row]];
            [hotSaleCell showWithData:_goodsArray[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        _currentSelectedIndex = indexPath.row;
        [self refreshUI];
    }
    else {
        if (indexPath.section == 0) {
            WGClassifyItem *item = _subArray[indexPath.row];
            WGClassifyDetailViewController *vc = [[WGClassifyDetailViewController alloc] init];
            vc.classifyId = item.id;
            vc.title = item.name;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            WGHomeFloorContentGoodItem *item = _goodsArray[indexPath.row];
            WGGoodDetailViewController *vc = [[WGGoodDetailViewController alloc] init];
            vc.goodId = item.id;
            vc.title = item.name;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end
