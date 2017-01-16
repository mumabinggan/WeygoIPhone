//
//  WGAddReceiptViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditReceiptViewController.h"
#import "WGEditReceiptCell.h"

@interface WGEditReceiptViewController ()
{
    JHTableView *_tableView;
    NSArray     *_placeholderArray;
    NSArray     *_contentArray;
}
@end

@interface WGEditReceiptViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGEditReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _placeholderArray = [NSArray arrayWithObjects:kStr(@"Raginone sociale"), kStr(@"Italia"), kStr(@"Recapito telefonico"), kStr(@"Indirizzo"), kStr(@"N civico"), kStr(@"Citta"), kStr(@"CAP"), kStr(@"Stato"), kStr(@"Codice fiscale"), nil];
    _contentArray = [NSArray arrayWithObjects:
                         [NSString safeString:_receipt.companyName],
                         [NSString safeString:_receipt.italia],
                         [NSString safeString:_receipt.phone],
                         [NSString safeString:_receipt.address],
                         [NSString safeString:_receipt.civico],
                         [NSString safeString:_receipt.city],
                         [NSString safeString:_receipt.cap],
                         [NSString safeString:_receipt.province],
                         [NSString safeString:_receipt.taxCode], nil];
}

- (void)initSubView {
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40))];
    addBtn.layer.masksToBounds = YES;
    [addBtn setTitle:kStr(@"Save") forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(UIButton *)sender {
    NSInteger count = [_tableView numberOfRowsInSection:0];
    for (int num = 0; num < count; ++num) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:num inSection:0];
        WGEditReceiptCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        NSString *content = cell.textField.text;
        if (self.onApply) {
            self.onApply();
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGEditReceiptViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [NSString stringWithFormat:@"cellId_%ld", indexPath.row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        WGEditReceiptCell *editReceiptCell = [[WGEditReceiptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        editReceiptCell.textField.placeholder = _placeholderArray[indexPath.row];
        cell = editReceiptCell;
        [cell showWithData:_contentArray[indexPath.row]];
    }
    return cell;
}

@end
