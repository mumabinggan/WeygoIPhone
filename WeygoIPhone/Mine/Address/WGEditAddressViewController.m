//
//  WGEditAddressViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditAddressViewController.h"
#import "WGEditAddressCell.h"
#import "WGEditAddressViewController+Request.h"
#import "WGAddressCityListResponse.h"

@interface WGEditAddressViewController ()
{
    JHButton *_addBtn;
    UIPickerView *_pickerView;
}
@end

@interface WGEditAddressViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@interface WGEditAddressViewController (PickerView)<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation WGEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Address_Add_Title");
    [self loadAddressCitys];
    if (_addressId != 0) {
        [self loadAddressDetail];
    }
}

- (void)initData {
    _placeholderArray = [NSArray arrayWithObjects:
                         kStr(@"Cognome"),
                         kStr(@"Nome"),
                         kStr(@"Italia"),
                         kStr(@"Indirizzo"),
                         kStr(@"Telefono/Cellulare"),
                         kStr(@"Citta"),
                         kStr(@"CAP"),
                         kStr(@"Indirizzo"),
                         kStr(@"Numero civico"),
                         kStr(@"Scala"),
                         kStr(@"Ascensore"),
                         kStr(@"Piano"),
                         nil];
    _address = [[WGAddress alloc] init];
//    _contentMArray = [NSMutableArray arrayWithObjects:
//                      [NSString safeString:_address.firstName],
//                      [NSString safeString:_address.lastName],
//                      [NSString safeString:_address.country],
//                      [NSString safeString:_address.phone],
//                      [NSString safeString:_address.cap],
//                      [NSString safeString:_address.city],
//                      [NSString safeString:_address.address],
//                      [NSString safeString:_address.streetNumber],
//                      [NSString safeString:_address.citofono],
//                      [NSString safeString:_address.scala],
//                      @(_address.ascensore).stringValue,
//                      [NSString safeString:_address.piano],
//                      nil];
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
    if (_addressId != 0) {
        _addBtn.layer.opacity = 0.0f;
        _tableView.layer.opacity = 0.0f;
    }
}

- (void)initCityPickerView {
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
    pickerView.tag = 1000;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
}

- (void)initLiftPickerView {
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
    pickerView.tag = 1001;
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
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
        _addBtn.layer.opacity = 1.0f;
    }];
}

- (void)touchAddBtn:(UIButton *)sender {
    [self loadAddAddress];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _placeholderArray.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (void)handleEndEdit:(JHTableViewCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger row = indexPath.row;
    if (row == 10) {
        //无操作
    }
    else {
        WGBaseAddressAndReceiveEditCell *editCell = (WGBaseAddressAndReceiveEditCell *)cell;
        if (row == 0) {
            _address.firstName = editCell.textField.text;
        }
        else if (row == 1) {
            _address.lastName = editCell.textField.text;
        }
        else if (row == 3) {
            _address.phone = editCell.textField.text;
        }
        else if (row == 4) {
            _address.cap = editCell.textField.text;
        }
        else if (row == 5) {
            //_address.cap = editCell.textField.text;
        }
        else if (row == 6) {
            _address.address = editCell.textField.text;
        }
        else if (row == 7) {
            _address.streetNumber = editCell.textField.text;
        }
        else if (row == 8) {
            _address.citofono = editCell.textField.text;
        }
        else if (row == 9) {
            _address.scala = editCell.textField.text;
        }
        else if (row == 11) {
            _address.piano = editCell.textField.text;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGEditAddressViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    NSInteger row = indexPath.row;
    cellId = [NSString stringWithFormat:@"cellId_%d", (row == 10)];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (row == 10) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = WGAppLightNameLabelColor;
            cell.textLabel.font = kAppAdaptFont(14);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            WGEditAddressCell *editCell = [[WGEditAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            __weak id weakSelf = self;
            editCell.onEndEdit = ^(JHTableViewCell *cell) {
                [weakSelf handleEndEdit:cell];
            };
            if (row == 2 || row == 5) {
                editCell.textField.enabled = NO;
            }
            else {
                editCell.textField.enabled = YES;
            }
            cell = editCell;
        }
    }
    NSString *placeHolder =  _placeholderArray[indexPath.row];
    if ([cell isKindOfClass:[WGEditAddressCell class]]) {
        WGEditAddressCell *editCell = (WGEditAddressCell *)cell;
        editCell.textField.placeholder = placeHolder;
        if (row == 0) {
            editCell.textField.text = _address.firstName;
        }
        else if (row == 1) {
            editCell.textField.text = _address.lastName;
        }
        else if (row == 2) {
            editCell.textField.text = _address.country;
        }
        else if (row == 3) {
            editCell.textField.text = _address.phone;
        }
        else if (row == 4) {
            editCell.textField.text = _address.cap;
        }
        else if (row == 5) {
            editCell.textField.text = _address.city;
        }
        else if (row == 6) {
            editCell.textField.text = _address.address;
        }
        else if (row == 7) {
            editCell.textField.text = _address.streetNumber;
        }
        else if (row == 8) {
            editCell.textField.text = _address.citofono;
        }
        else if (row == 9) {
            editCell.textField.text = _address.scala;
        }
        else if (row == 11) {
            editCell.textField.text = _address.piano;
        }
        if (5 == row) {
            editCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            editCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else {
        cell.textLabel.text = placeHolder;
        cell.detailTextLabel.text = _address.currentAscensore;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) {
        [self initCityPickerView];
    }
    else if (indexPath.row == 10) {
        [self initLiftPickerView];
    }
}

@end

@implementation WGEditAddressViewController (PickerView)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        return _cityArray.count;
    }
    else if (pickerView.tag == 1001) {
        return 2;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        WGAddressCityListItem *item = _cityArray[row];
        return item.name;
    }
    else if (pickerView.tag == 1001) {
        return _address.ascensores[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        WGAddressCityListItem *item = _cityArray[row];
        _address.cityId = item.value;
        _address.city = item.name;
    }
    else if (pickerView.tag == 1001) {
        _address.ascensore = (int)row;
    }
    [_tableView reloadData];
}

@end
