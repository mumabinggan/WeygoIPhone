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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"----set---viewWillDisappear----");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Setting");
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
        
    }
    else if (indexPath.row == 3) {
        //国家切换
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
                UIActivityIndicatorView *accessoryView = (UIActivityIndicatorView *)cell.accessoryView;
                [accessoryView stopAnimating];
            }];
        }
    }
}

@end
