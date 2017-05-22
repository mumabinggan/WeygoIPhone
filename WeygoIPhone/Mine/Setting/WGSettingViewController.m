//
//  WGSettingViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSettingViewController.h"
#import "JHCacheManager.h"
#import "AppDelegate+UI.h"
#import "WGPostCodePopoverView.h"

@interface WGSettingViewController ()
{
    JHTableView *_tableView;
    
    NSArray *_languageArray;
    NSInteger _selectedLanguageIndex;
    
    JHView *_sortPickerBgView;
    UIPickerView *_sortPickerView;
    JHButton *_closeBtn;
}
@end

@interface WGSettingViewController (PickerViewDelegate) <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@interface WGSettingViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Setting");
}

- (void)initData {
    _languageArray = @[kStr(@"Italiano"), kStr(@"China")];
    _selectedLanguageIndex = [JHLocalizableManager sharedManager].type;
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.userInteractionEnabled = YES;
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kWhiteColor;
    _tableView.tableFooterView = [self createFooterView];
    [contentView addSubview:_tableView];
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(88))];
    
    JHButton *chatBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [chatBtn setTitle:kStr(@"Log out") forState:UIControlStateNormal];
    chatBtn.titleLabel.font = kAppAdaptFont(14);
    [chatBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(touchChatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:chatBtn];
    
    return footerView;
}

- (void)touchChatBtn:(UIButton *)sender {
    //聊天
}

- (void)openPickerView {
    if (_sortPickerView) {
        [self removePickerView];
    }
    else {
        
        _closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
        [_closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setBackgroundColor:kHRGBA(0x000000, 0.5)];
        [self.view addSubview:_closeBtn];
        
        _sortPickerBgView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(300), kDeviceWidth, kAppAdaptHeight(300))];
        _sortPickerBgView.backgroundColor = kWhiteColor;
        [self.view addSubview:_sortPickerBgView];
        
        _sortPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(60), kDeviceWidth, kAppAdaptHeight(200))];
        _sortPickerView.backgroundColor = kRGB(244, 244, 244);
        _sortPickerView.delegate = self;
        _sortPickerView.dataSource = self;
        _sortPickerView.showsSelectionIndicator = YES;
        [_sortPickerView selectRow:_selectedLanguageIndex inComponent:0 animated:NO];
        _sortPickerBgView.backgroundColor = _sortPickerView.backgroundColor;
        [_sortPickerBgView addSubview:_sortPickerView];
        
        JHButton *cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(10), kAppAdaptWidth(50), kAppAdaptHeight(30))];
        [cancelBtn setTitle:kStr(@"Mine_Logout_Cancel") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = kAppAdaptFont(16);
        [_sortPickerBgView addSubview:cancelBtn];
        
        JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(58), kAppAdaptWidth(10), kAppAdaptWidth(50), kAppAdaptHeight(30))];
        [confirmBtn setTitle:kStr(@"Mine_Logout_Ok") forState:UIControlStateNormal];
        [confirmBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.titleLabel.font = kAppAdaptFont(16);
        [_sortPickerBgView addSubview:confirmBtn];
    }
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

- (void)touchCancelBtn:(JHButton *)sender {
    [self removePickerView];
}

- (void)removePickerView {
    [_sortPickerBgView removeFromSuperview];
    _sortPickerBgView = nil;
    [_sortPickerView removeFromSuperview];
    _sortPickerView = nil;
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

- (void)touchConfirmBtn:(JHButton *)sender {
    _selectedLanguageIndex = [_sortPickerView selectedRowInComponent:0];
    [self removePickerView];
    [_tableView reloadData];
    [[WGApplication sharedApplication] setLanguage:_selectedLanguageIndex];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadRootViewController:nil withOptions:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGSettingViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    cellId = [NSString stringWithFormat:@"cellId_%ld", indexPath.row];
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSString *text = nil;
        UIColor *textColor = WGAppLightNameLabelColor;
        NSString *detailText = nil;
        UIColor *detailTextColor = WGAppNameLabelColor;
        UIColor *backgroundColor = nil;
        NSTextAlignment textAlignment = NSTextAlignmentLeft;
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        if (indexPath.row == 0) {
            textAlignment = NSTextAlignmentCenter;
            text = kStr(@"Informazioni");
            textColor = WGAppNameLabelColor;
            backgroundColor = kHRGB(0xF8FAFA);
        }
        else if (indexPath.row == 1) {
            style = UITableViewCellStyleValue1;
            text = kStr(@"Inserisci CAP");
            detailText = [WGApplication sharedApplication].currentPostCode;
        }
        else if (indexPath.row == 2) {
            textAlignment = NSTextAlignmentCenter;
            text = kStr(@"System");
            textColor = WGAppNameLabelColor;
            backgroundColor = kHRGB(0xF8FAFA);
        }
        else if (indexPath.row == 3) {
            style = UITableViewCellStyleValue1;
            text = kStr(@"Seleziona lingua");
            accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            detailText = _languageArray[_selectedLanguageIndex];
        }
        else if (indexPath.row == 4) {
            style = UITableViewCellStyleValue1;
            text = kStr(@"Versione");
            accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            detailText = kAppVersion;
        }
        else if (indexPath.row == 5) {
            style = UITableViewCellStyleValue1;
            text = kStr(@"Svuota cache");
        }
        cell = [[JHTableViewCell alloc] initWithStyle:style reuseIdentifier:cellId];
        cell.textLabel.text = text;
        cell.textLabel.textAlignment = textAlignment;
        cell.detailTextLabel.text = detailText;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = textColor;
        cell.detailTextLabel.textColor = detailTextColor;
        cell.accessoryType = accessoryType;
        cell.backgroundColor = backgroundColor;
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(48) - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
            line.backgroundColor = WGAppSeparateLineColor;
            [cell.contentView addSubview:line];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        WGPostCodePopoverView *view = [[WGPostCodePopoverView alloc] initWithFrame:self.view.bounds];
        view.onApply = ^(NSString *postCode) {
            [_tableView reloadData];
        };
        [view show];
        return;
    }
    else if (indexPath.row == 3) {
        //国家切换
        [self openPickerView];
    }
    else if (indexPath.row == 4) {
        //关于
    }
    else if (indexPath.row == 5) {
        JHTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            UIActivityIndicatorView *animalView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [animalView startAnimating];
            animalView.hidesWhenStopped = YES;
            cell.accessoryView = animalView;
            [[JHCacheManager sharedCacheManager] clearCache:^(void) {
                [self showWarningMessage:@""];
                UIActivityIndicatorView *accessoryView = (UIActivityIndicatorView *)cell.accessoryView;
                [accessoryView stopAnimating];
            }];
        }
    }
}

@end

@implementation WGSettingViewController (PickerViewDelegate)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _languageArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kAppAdaptHeight(40);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _languageArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //[self loadData:YES pulling:NO];
}

@end
