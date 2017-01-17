//
//  WGBaseEditAddressAndReceiptViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseEditAddressAndReceiptViewController.h"
#import "WGBaseAddressAndReceiveEditCell.h"

@interface WGBaseEditAddressAndReceiptViewController ()

@end

@interface WGBaseEditAddressAndReceiptViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGBaseEditAddressAndReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [addBtn setTitle:kStr(@"Save") forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(UIButton *)sender {
    //contentArray to add
    DLog(@"---content = %@", _contentMArray);
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _placeholderArray.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (void)handleEndEdit:(JHTableViewCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if (_contentMArray.count > indexPath.row) {
        _contentMArray[indexPath.row] = ((WGBaseAddressAndReceiveEditCell *)cell).textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGBaseEditAddressAndReceiptViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        WGBaseAddressAndReceiveEditCell *editCell = [[WGBaseAddressAndReceiveEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        __weak id weakSelf = self;
        editCell.onEndEdit = ^(JHTableViewCell *cell) {
            [weakSelf handleEndEdit:cell];
        };
        cell = editCell;
    }
    ((WGBaseAddressAndReceiveEditCell *)cell).textField.placeholder = _placeholderArray[indexPath.row];
    ((WGBaseAddressAndReceiveEditCell *)cell).textField.text = _contentMArray[indexPath.row];
    return cell;
}

@end
