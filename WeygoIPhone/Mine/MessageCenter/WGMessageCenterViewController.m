//
//  WGMessageCenterViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageCenterViewController.h"
#import "WGMessageItemCell.h"
#import "WGMessageItem.h"
#import "WGMessageCenterViewController+Request.h"
#import "WGSegmentView.h"

@interface WGMessageCenterViewController ()
{
    WGSegmentView *_titleSegmentView;
}
@end

@interface WGMessageCenterViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    WGMessageItem *item = [[WGMessageItem alloc] init];
    item.title = @"郑淡艺术硕士";
    item.time = @"1322.232332";
    item.content = @"本信息读音苛 kē 苛hē部首笔画";
    item.isRead = NO;
    
    WGMessageItem *item2 = [[WGMessageItem alloc] init];
    item2.title = @"郑硕士";
    item2.time = @"1322.232332";
    item2.content = @"搜服九九九(www.sf999.com)是全球最大的传奇私服发布网,为热血传奇私服玩家提供最快捷的新开传奇私服开服信息";
    item2.isRead = NO;
    
    WGMessageItem *item3 = [[WGMessageItem alloc] init];
    item3.title = @"艺术硕士";
    item3.time = @"1322.232332";
    item3.content = @"本信息读音苛 kē 苛hē部首笔画";
    item3.isRead = YES;
    
    WGMessageItem *item4 = [[WGMessageItem alloc] init];
    item4.title = @"郑淡艺术";
    item4.time = @"1322.232332";
    item4.content = @"成神之路!SF的最全写手攻略! SF站娘形象及表情包 SF轻小说新版图文投稿攻略 净化网络文学环境,是我们共同的责任 人气风向标 (更新稳定有特点)... 喵小六成神之路!SF的最全写手攻略! SF站娘形象及表情包 SF轻小说新版图";
    item4.isRead = NO;
    
    _allMArray = @[item, item3];
    _newMArray = @[item4, item3, item2];
    _deliverMArray = @[item];
    
    _currentTabType = WGMessageTabTypeAll;
    _currentArray = _allMArray;
    
//    _allMArray = [[NSMutableArray alloc] init];
//    _newMArray = [[NSMutableArray alloc] init];
//    _deliverMArray = [[NSMutableArray alloc] init];
//    _currentArray = _allMArray;
//    _currentTabType = WGMessageTabTypeAll;
}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"MessageCenter Title");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, kAppNavigationVCY, kDeviceWidth, kAppAdaptHeight(44))];
    [_titleSegmentView setTitleArray:@[kStr(@"MessageCenter All"), kStr(@"MessageCenter New Message"), kStr(@"MessageCenter Deliver")]];
    _titleSegmentView.backgroundColor = kWhiteColor;
    __weak id weakSelf = self;
    _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
        [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
    };
    _titleSegmentView.layer.shadowColor = kBlackColor.CGColor;
    _titleSegmentView.layer.shadowOffset = CGSizeMake(0, 1);
    _titleSegmentView.layer.shadowRadius = 1;
    _titleSegmentView.layer.shadowOpacity = 0.15;
    [self.view addSubview:_titleSegmentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(kAppAdaptHeight(44), 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)index {
    if (index == 0) {
        _currentTabType = WGMessageTabTypeAll;
        _currentArray = _allMArray;
    }
    else if (index == 1) {
        _currentTabType = WGMessageTabTypeNew;
        _currentArray = _newMArray;
    }
    else if (index == 2) {
        _currentTabType = WGMessageTabTypeDeliver;
        _currentArray = _deliverMArray;
    }
    if (_currentArray == nil || _currentArray.count == 0) {
        [self loadMessageList:YES pulling:NO];
    }
    [self refreshUI];
}

- (void)refreshUI {
    [_tableView reloadData];
}

- (void)handleMore:(WGMessageItem *)item {
    item.displayAllContent = YES;
    [self refreshUI];
    [self loadMessageDetail:item.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGMessageCenterViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _currentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_currentArray.count == section + 1) {
        return kAppAdaptHeight(0.5);
    }
    return kAppAdaptHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGMessageItem *item = _currentArray[indexPath.section];
    return [WGMessageItemCell heightWithData:item];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    NSInteger section = indexPath.section;
    cellId = [NSString stringWithFormat:@"cellId_%ld", section];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        __weak id weakSelf = self;
        WGMessageItemCell *messageItemCell = [[WGMessageItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        messageItemCell.onMore = ^(WGMessageItem *item) {
            [weakSelf handleMore:item];
        };
        cell = messageItemCell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WGMessageItem *item = _currentArray[section];
    [cell showWithData:item];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WGMessageItem *item = _currentArray[indexPath.section];
        [self loadDeleteMessage:item.id];
    }
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadMessageList:NO pulling:YES];
}

@end
