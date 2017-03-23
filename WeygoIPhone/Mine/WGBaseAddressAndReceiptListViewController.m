//
//  WGBaseAddressAndReceiptListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseAddressAndReceiptListViewController.h"
#import "WGBaseAddressAndReceiptListCell.h"

@interface WGBaseAddressAndReceiptListViewController ()
{
    TWRefreshTableView  *_tableView;
}
@end

@interface WGBaseAddressAndReceiptListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGBaseAddressAndReceiptListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    [super initSubView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kStr(@"") style:UIBarButtonItemStylePlain target:self action:@selector(touchClearBtn:)];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(56 + 16), kDeviceHeight - kAppAdaptHeight(56 + 16), kAppAdaptWidth(56), kAppAdaptHeight(56))];
    [addBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(JHButton *)sender {
    
}

- (void)touchClearBtn:(id)sender {
    //after request complete
    if (self.onClear) {
        self.onClear();
    }
}

- (void)refreshTableView {
    [_tableView reloadData];
}

- (void)handleDefault:(WGObject *)object {
    
}

- (void)handleUse:(WGObject *)object {
    
}

- (void)handleModify:(WGObject *)object {

}

- (NSInteger)numberOfSections {
    return _dataMArray.count;
}

- (void)beginRefreshHeader {
    
}

- (void)beginRefreshFooter {
    
}

- (Class)cellClass {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGBaseAddressAndReceiptListViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0) ? 0 : kAppAdaptHeight(8);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(136);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        Class clazz = [self cellClass];
        WGBaseAddressAndReceiptListCell *receiptCell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        __weak id weakSelf = self;
        receiptCell.onDefault = ^(WGObject *object) {
            [weakSelf handleDefault:object];
        };
        receiptCell.onUse = ^(WGObject *object) {
            [weakSelf handleUse:object];
        };
        receiptCell.onModify = ^(WGObject *object) {
            [weakSelf handleModify:object];
        };
        cell = receiptCell;
    }
    [cell showWithData:_dataMArray[indexPath.section]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataMArray removeObjectAtIndex:indexPath.section];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
//    
//}
//
//- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
//    
//}

@end
