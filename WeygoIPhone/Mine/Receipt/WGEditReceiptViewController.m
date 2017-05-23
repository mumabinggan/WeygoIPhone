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
    JHButton *_cancelBtn;
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

    _addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth/2 - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [_addBtn setTitle:kStr(@"Fax_Apply") forState:UIControlStateNormal];
    _addBtn.titleLabel.font = kAppAdaptFont(14);
    [_addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    _cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2 + kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth/2 - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppBaseColor];
    [_cancelBtn setTitle:kStr(@"Fax_Cancel") forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = kAppAdaptFont(14);
    [_cancelBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
}

- (void)touchAddBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.onApply) {
        self.onApply(_receipt);
    }
}

- (void)touchCancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.onCancel) {
        self.onCancel();
    }
}

- (void)initCountryPickerView {
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    _closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [_closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn setBackgroundColor:kHRGBA(0x000000, 0.5)];
    [self.view addSubview:_closeBtn];
    
    _sortPickerBgView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(300), kDeviceWidth, kAppAdaptHeight(300))];
    _sortPickerBgView.backgroundColor = kWhiteColor;
    [self.view addSubview:_sortPickerBgView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(60), kDeviceWidth, kAppAdaptHeight(200))];
    pickerView.backgroundColor = kRGB(244, 244, 244);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    if (_receipt) {
        for (int num = 0; num < _countryArray.count; ++num) {
            WGReceiptCountryListItem *item = _countryArray[num];
            if ([item.value isEqualToString:_receipt.countryId]) {
                [pickerView selectRow:num inComponent:0 animated:NO];
                break;
            }
        }
    }
    [_sortPickerBgView addSubview:pickerView];
    _pickerView = pickerView;
    
    _sortPickerBgView.backgroundColor = _pickerView.backgroundColor;
    NSString *titleString = kStr(@"Mine_Logout_Cancel");
    float width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
    JHButton *cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
    [cancelBtn setTitle:titleString forState:UIControlStateNormal];
    [cancelBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = kAppAdaptFont(16);
    [_sortPickerBgView addSubview:cancelBtn];
    
    titleString = kStr(@"Mine_Logout_Ok");
    width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
    JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - width - kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
    [confirmBtn setTitle:titleString forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = kAppAdaptFont(16);
    [_sortPickerBgView addSubview:confirmBtn];
}

- (void)touchPickerCancelBtn:(JHButton *)sender {
    [self removePickerView];
}

- (void)removePickerView {
    [_sortPickerBgView removeFromSuperview];
    _sortPickerBgView = nil;
    [_pickerView removeFromSuperview];
    _pickerView = nil;
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

- (void)touchConfirmBtn:(JHButton *)sender {
    NSInteger row = [_pickerView selectedRowInComponent:0];
    WGReceiptCountryListItem *item = _countryArray[row];
    _receipt.country = item.label;
    _receipt.countryId = item.value;
    [self removePickerView];
    [_tableView reloadData];
}

- (void)touchCloseBtn:(JHButton *)sender {
    [UIView animateWithDuration:0.3 animations:^() {
        _sortPickerBgView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [_sortPickerBgView removeFromSuperview];
            _sortPickerBgView = nil;
        }
    }];
    [sender removeFromSuperview];
    sender = nil;
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^() {
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
        _receipt.cap = editCell.textField.text;
    }
    else if (row == 7) {
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
            editCell.textField.text = _receipt.cap;
        }
        else if (row == 7) {
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

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kAppAdaptHeight(40);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    WGReceiptCountryListItem *item = _countryArray[row];
    return item.label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    WGReceiptCountryListItem *item = _countryArray[row];
//    _receipt.country = item.label;
//    _receipt.countryId = item.value;
//    [_tableView reloadData];
}

@end

