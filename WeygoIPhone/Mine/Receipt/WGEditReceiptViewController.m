//
//  WGAddReceiptViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditReceiptViewController.h"
#import "WGEditReceiptCell.h"
#import "WGEditReceiptViewController+Request.h"

@interface WGEditReceiptViewController ()
{
    JHButton *_addBtn;
    UIPickerView *_pickerView;
}
@end

@interface WGEditReceiptViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@interface WGEditReceiptViewController (PickerView)<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation WGEditReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"AddReceipt_Title");
    [self loadReceiptCountry];
}

- (void)initData {
    _placeholderArray = [NSArray arrayWithObjects:kStr(@"Raginone sociale"), kStr(@"Italia"), kStr(@"Recapito telefonico"), kStr(@"Indirizzo"), kStr(@"N civico"), kStr(@"Citta"), kStr(@"CAP"), kStr(@"Codice fiscale"), nil];
    if (!_receipt) {
        _receipt = [[WGReceipt alloc] init];
    }
}

- (void)initSubView {
    [super initSubView];
    CGRect frame = self.view.bounds;
    frame.size.height -= kAppAdaptHeight(80);
    _tableView = [[JHTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:_tableView];
    
    _addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [_addBtn setTitle:kStr(@"PersonInfo_Save") forState:UIControlStateNormal];
    _addBtn.titleLabel.font = kAppAdaptFont(14);
    [_addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
}

- (void)touchAddBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.onApply) {
        self.onApply(_receipt);
    }
}

- (void)initCountryPickerView {
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(130), kDeviceWidth, kAppAdaptHeight(130))];
    pickerView.backgroundColor = kRGB(244, 244, 244);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
}

- (void)touchCloseBtn:(JHButton *)sender {
    [UIView animateWithDuration:0.3 animations:^() {
        _pickerView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [_pickerView removeFromSuperview];
            _pickerView = nil;
        }
    }];
    [sender removeFromSuperview];
    sender = nil;
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.25 animations:^() {
        _tableView.layer.opacity = 1.0f;
        _addBtn.layer.opacity = 1.0f;
    }];
}

- (void)handleEndEdit:(JHTableViewCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger row = indexPath.row;
    WGBaseAddressAndReceiveEditCell *editCell = (WGBaseAddressAndReceiveEditCell *)cell;
    if (row == 0) {
        _receipt.companyName = editCell.textField.text;
    }
    else if (row == 2) {
        _receipt.phone = editCell.textField.text;
    }
    else if (row == 3) {
        _receipt.address = editCell.textField.text;
    }
    else if (row == 4) {
        _receipt.civico = editCell.textField.text;
    }
    else if (row == 5) {
        _receipt.city = editCell.textField.text;
    }
    else if (row == 6) {
        _receipt.address = editCell.textField.text;
    }
    else if (row == 7) {
        _receipt.cap = editCell.textField.text;
    }
    else if (row == 8) {
        _receipt.taxCode = editCell.textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGEditReceiptViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _placeholderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    NSInteger row = indexPath.row;
    cellId = [NSString stringWithFormat:@"cellId_%d", (row == 1)];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (row == 1) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = WGAppNameLabelColor;
            cell.textLabel.font = kAppAdaptFont(14);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            WGEditReceiptCell *editCell = [[WGEditReceiptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            __weak id weakSelf = self;
            editCell.onEndEdit = ^(JHTableViewCell *cell) {
                [weakSelf handleEndEdit:cell];
            };
            cell = editCell;
        }
    }
    NSString *placeHolder =  _placeholderArray[indexPath.row];
    if ([cell isKindOfClass:[WGEditReceiptCell class]]) {
        WGEditReceiptCell *editCell = (WGEditReceiptCell *)cell;
        editCell.textField.placeholder = placeHolder;
        if (row == 0) {
            editCell.textField.text = _receipt.companyName;
        }
        else if (row == 2) {
            editCell.textField.text = _receipt.phone;
        }
        else if (row == 3) {
            editCell.textField.text = _receipt.address;
        }
        else if (row == 4) {
            editCell.textField.text = _receipt.civico;
        }
        else if (row == 5) {
            editCell.textField.text = _receipt.city;
        }
        else if (row == 6) {
            editCell.textField.text = _receipt.address;
        }
        else if (row == 7) {
            editCell.textField.text = _receipt.cap;
        }
        else if (row == 8) {
            editCell.textField.text = _receipt.taxCode;
        }
    }
    else {
        cell.textLabel.text = placeHolder;
        cell.textLabel.text = _receipt.country;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self initCountryPickerView];
    }
}

@end

@implementation WGEditReceiptViewController (PickerView)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _countryArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    WGReceiptCountryListItem *item = _countryArray[row];
    return item.label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    WGReceiptCountryListItem *item = _countryArray[row];
    _receipt.country = item.label;
    _receipt.countryId = item.value;
    [_tableView reloadData];
}

@end

