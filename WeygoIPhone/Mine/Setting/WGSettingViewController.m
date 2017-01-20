//
//  WGSettingViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSettingViewController.h"
#import "JHCacheManager.h"

@interface WGSettingViewController ()
{
    JHTableView *_tableView;
}
@end

@interface WGSettingViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Setting");
}

- (void)initSubView {
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
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
    
    JHButton *logoutBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(52), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [logoutBtn setTitle:kStr(@"Log out") forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = kAppAdaptFont(14);
    [logoutBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(touchLogoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutBtn];
    
    return footerView;
}

- (void)touchLogoutBtn:(UIButton *)sender {
    //请求服务退出
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
        }
        else if (indexPath.row == 4) {
            style = UITableViewCellStyleValue1;
            text = kStr(@"Versione");
            accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            text = kAppVersion;
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
        
    }
    else if (indexPath.row == 3) {
        //
    }
    else if (indexPath.row == 4) {
        //关于
    }
    else if (indexPath.row == 5) {
        JHTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            UIActivityIndicatorView *animalView = [[UIActivityIndicatorView alloc] init];
            [animalView startAnimating];
            animalView.hidesWhenStopped = YES;
            cell.accessoryView = animalView;
            [[JHCacheManager sharedCacheManager] clearCache:^(void) {
                UIActivityIndicatorView *accessoryView = (UIActivityIndicatorView *)cell.accessoryView;
                [accessoryView stopAnimating];
            }];
        }
    }
}

@end
