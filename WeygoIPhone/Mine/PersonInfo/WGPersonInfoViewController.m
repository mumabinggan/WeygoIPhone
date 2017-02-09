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

@interface WGPersonInfoViewController ()

@end

@interface WGPersonInfoViewController ()
{
    JHTableView *_tableView;
    NSArray *_titleMArray;
    //NSMutableArray  *_contentMArray;
}
@end

@interface WGPersonInfoViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _titleMArray = [NSArray arrayWithObjects:kStr(@"PersonInfo_Header"), kStr(@"PersonInfo_Name"), kStr(@"PersonInfo_SurName"), kStr(@"PersonInfo_Number"), kStr(@"PersonInfo_Mobile"), kStr(@"PersonInfo_Email"), kStr(@"PersonInfo_Sex"), kStr(@"PersonInfo_Birth"), kStr(@"PersonInfo_tax"), kStr(@"PersonInfo_ChangePW"), nil];
    _user = [WGApplication sharedApplication].user;
}

- (void)initSubView {
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kDeviceHeight - kAppAdaptHeight(56), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [addBtn setTitle:kStr(@"Save") forState:UIControlStateNormal];
    addBtn.titleLabel.font = kAppAdaptFont(14);
    [addBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(UIButton *)sender {
    //contentArray to add
    //DLog(@"---content = %@", _contentMArray);
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
            [cell showWithData:(JHObject *)([_user isMan] ? @"" : @"")];
        }
        else if (indexPath.row == 3) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", _user.number];
        }
        else if (indexPath.row == 6) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", _user.sex];
        }
        else if (indexPath.row == 7) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", _user.birth];
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
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        
    }
    if (indexPath.row == 7) {
        //
    }
    if (indexPath.row == 9) {
        //忘记密码
    }
}

@end
