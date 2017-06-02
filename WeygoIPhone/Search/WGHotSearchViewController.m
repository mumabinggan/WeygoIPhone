//
//  WGHotSearchViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHotSearchViewController.h"
#import "WGHotSearchRequest.h"
#import "WGHotSearchResponse.h"
#import "WGHotSearchCell.h"
#import "WGHotSearchHistoryCell.h"
#import "WGSearchGoodListViewController.h"
#import "WGSearchViewController.h"

@interface WGHotSearchViewController ()
{
    JHTableView *_tableView;
}
@end

@interface WGHotSearchViewController (Request)

- (void)loadHotSearch;

@end

@interface WGHotSearchViewController (TableView) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGHotSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadHotSearch];
}

- (void)initData {
    _historyArray = [[WGApplication sharedApplication] getLocalSettingHistorySearchArray];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:contentView];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = kAppNavigationVCY;
    frame.size.height = kDeviceHeight - kAppNavigationVCY;
    _tableView = [[JHTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.layer.opacity = 1.0f;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    [contentView addSubview:_tableView];
    
    [self refreshUI];
}

- (void)refreshHistory {
    _historyArray = [[WGApplication sharedApplication] getLocalSettingHistorySearchArray];
    [_tableView reloadData];
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.05 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)handleOnApplyKeyword:(WGSearchKeywordItem *)item {
    //加入记录
    [[WGApplication sharedApplication] addLocalSettingHistorySearch:item];
    
    WGSearchViewController *vc = [[WGSearchViewController alloc] init];
    vc.name = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleOnDelete:(WGSearchKeywordItem *)item {
    [[WGApplication sharedApplication] cleanLocalSettingHistorySearch:item.name];
    [self refreshHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGHotSearchViewController (Request)

- (void)loadHotSearch {
    WGHotSearchRequest *request = [[WGHotSearchRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGHotSearchResponse class] success:^(JHResponse *response) {
        [weakSelf handleHotSearchResponse:(WGHotSearchResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleHotSearchResponse:(WGHotSearchResponse *)response {
    if (response.success) {
        _hotArray = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end

@implementation WGHotSearchViewController (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    NSInteger row = indexPath.row;
    if (row == 0) {
        if (_hotArray && _hotArray.count > 0) {
            height = kAppAdaptHeight(40);
        }
    }
    else if (row == 1) {
        height = [WGHotSearchCell heightWithArray:_hotArray];
    }
    else if (row == 2) {
        if (_historyArray && _historyArray.count) {
            height = kAppAdaptHeight(40);
        }
    }
    else if (row == 3) {
        height = [WGHotSearchHistoryCell heightWithArray:_historyArray];
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    NSInteger row = indexPath.row;
    cellId = [NSString stringWithFormat:@"cellId_%ld", row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (row == 0 || row == 2) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.textLabel.font = kAppAdaptFont(14);
            cell.backgroundColor = kHRGB(0xf8FAFA);
        }
        else if (row == 1) {
            WeakSelf;
            WGHotSearchCell *hotCell = [[WGHotSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            hotCell.onApply = ^(WGSearchKeywordItem *item) {
                [weakSelf handleOnApplyKeyword:item];
            };
            cell = hotCell;
        }
        else if (row == 3) {
            WeakSelf;
            WGHotSearchHistoryCell *historyCell = [[WGHotSearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            historyCell.onApply = ^(WGSearchKeywordItem *item) {
                [weakSelf handleOnApplyKeyword:item];
            };
            historyCell.onDelete = ^(WGSearchKeywordItem *item) {
                [weakSelf handleOnDelete:item];
            };
            cell = historyCell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (row == 0) {
        cell.textLabel.text = kStr(@"Search_Hot_Title");
        cell.imageView.image = [UIImage imageNamed:@"hot_search"];
    }
    else if (row == 1) {
        [cell showWithArray:_hotArray];
    }
    else if (row == 2) {
        cell.textLabel.text = kStr(@"Search_History_Title");
        cell.imageView.image = [UIImage imageNamed:@"history_search"];
    }
    else if (row == 3) {
        [cell showWithArray:_historyArray];
    }
    return cell;
}

@end
