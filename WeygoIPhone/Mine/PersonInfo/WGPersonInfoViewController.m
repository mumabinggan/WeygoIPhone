//
//  WGPersonInfoViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPersonInfoViewController.h"
#import "WGEditPersonInfoCell.h"
#import "WGPersonHeaderCell.h"
#import "WGPersonInfoViewController+Request.h"
#import "WGForgetPasswordViewController.h"

//for test
#import "WGBindThirdPartyViewController.h"

@interface WGPersonInfoViewController ()

@end

@interface WGPersonInfoViewController (PickerView) <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@interface WGPersonInfoViewController ()
{
    NSArray *_titleMArray;
    //NSMutableArray  *_contentMArray;

    UIView *_pickerView;
}
@end

@interface WGPersonInfoViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"PersonInfo_Title");
    //[self loadPersonInfo];
}

- (void)initData {
    _titleMArray = [NSArray arrayWithObjects:kStr(@"PersonInfo_Header"), kStr(@"PersonInfo_Name"), kStr(@"PersonInfo_SurName"), kStr(@"PersonInfo_Number"), kStr(@"PersonInfo_Mobile"), kStr(@"PersonInfo_Email"), kStr(@"PersonInfo_Sex"), kStr(@"PersonInfo_Birth"), kStr(@"PersonInfo_tax"), kStr(@"PersonInfo_ChangePW"), nil];
    _user = [[WGApplication sharedApplication].user copy];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kWhiteColor;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [addBtn setTitle:kStr(@"PersonInfo_Save") forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(UIButton *)sender {
    [self loadCommitPersonInfo];
}

- (void)handleEndEdit:(JHTableViewCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if (indexPath.row == 1) {
        _user.name = ((WGEditPersonInfoCell *)cell).textField.text;
    }
    else if (indexPath.row == 2) {
        _user.surname = ((WGEditPersonInfoCell *)cell).textField.text;
    }
    else if (indexPath.row == 4) {
        _user.mobile = ((WGEditPersonInfoCell *)cell).textField.text;
    }
    else if (indexPath.row == 5) {
        _user.email = ((WGEditPersonInfoCell *)cell).textField.text;
    }
    else if (indexPath.row == 8) {
        _user.tax = ((WGEditPersonInfoCell *)cell).textField.text;
    }
}

- (void)initSexPickerView {
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIPickerView *sexPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(130), kDeviceWidth, kAppAdaptHeight(130))];
    sexPickerView.backgroundColor = kRGB(244, 244, 244);
    sexPickerView.delegate = self;
    sexPickerView.dataSource = self;
    sexPickerView.showsSelectionIndicator = YES;
    [sexPickerView selectRow:_user.sex inComponent:0 animated:NO];
    [self.view addSubview:sexPickerView];
    _pickerView = sexPickerView;
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

- (void)initDatePickerView {
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(160), kDeviceWidth, kAppAdaptHeight(160))];
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.backgroundColor = kGrayColor;
    [datePickerView addTarget:self action:@selector(handleDateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePickerView];
    _pickerView = datePickerView;
}

- (void)handleDateChange:(id)sender {
    UIDatePicker *datePicker = (UIDatePicker *)_pickerView;
    NSString *date = [datePicker.date stringWithFormat:@"yyyy-MM-dd"];
    _user.birth = date;
    [_tableView reloadData];
}

- (void)refreshUI {
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGPersonInfoViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == 0) ? kAppAdaptHeight(80) : kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    cellId = [NSString stringWithFormat:@"cellId_%ld", indexPath.row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        float height = 0.0f;
        if (indexPath.row == 0) {
            WGPersonHeaderCell *headerCell = [[WGPersonHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell = headerCell;
            height = kAppAdaptHeight(80);
        }
        else if (indexPath.row == 9) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            height = kAppAdaptHeight(48);
        }
        else if (indexPath.row == 3 ||
                 indexPath.row == 6 ||
                 indexPath.row == 7) {
            cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            if (indexPath.row != 3) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            height = kAppAdaptHeight(48);
        }
        else {
            __weak id weakSelf = self;
            WGEditPersonInfoCell *editCell = [[WGEditPersonInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            editCell.onEndEdit = ^(JHTableViewCell *cell) {
                [weakSelf handleEndEdit:cell];
            };
            cell = editCell;
            height = kAppAdaptHeight(48);
        }
        cell.textLabel.textColor = WGAppLightNameLabelColor;
        cell.detailTextLabel.textColor = WGAppNameLabelColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, height - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
        lineView.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:lineView];
    }
    cell.textLabel.text = _titleMArray[indexPath.row];
    if (indexPath.row != 9) {
        if (indexPath.row == 0) {
            ((WGPersonHeaderCell *)cell).headerImageView.image = [UIImage imageNamed:_user.userAvatar];
        }
        else if (indexPath.row == 3) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", _user.userId];
        }
        else if (indexPath.row == 6) {
            cell.detailTextLabel.text = _user.sexString;
        }
        else if (indexPath.row == 7) {
            cell.detailTextLabel.text = _user.birth;
        }
        else {
            NSArray *array = [NSMutableArray arrayWithObjects:
                              [NSNull null],
                              [NSString safeString:_user.name],
                              [NSString safeString:_user.surname],
                              [NSNull null],
                              [NSString safeString:_user.mobile],
                              [NSString safeString:_user.email],
                              [NSNull null],
                              [NSNull null],
                              [NSString safeString:_user.tax], nil];
            ((WGEditPersonInfoCell *)cell).textField.text = array[indexPath.row];
            if (4 == indexPath.row) {
                ((WGEditPersonInfoCell *)cell).textField.enabled = [NSString isNullOrEmpty:_user.mobile];
            }
            else if (5 == indexPath.row) {
                ((WGEditPersonInfoCell *)cell).textField.enabled = [NSString isNullOrEmpty:_user.email];
            }
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        //性别
        [self initSexPickerView];
    }
    if (indexPath.row == 7) {
        //日期
        [self initDatePickerView];
    }
    if (indexPath.row == 9) {
        WGBindThirdPartyViewController *vc = [[WGBindThirdPartyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        //忘记密码
//        WGForgetPasswordViewController *vc = [[WGForgetPasswordViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

@implementation WGPersonInfoViewController (PickerView)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kAppAdaptHeight(40);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _user.sexs[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _user.sex = (int)row;
    [_tableView reloadData];
}

@end
