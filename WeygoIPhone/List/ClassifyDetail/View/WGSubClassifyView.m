//
//  WGSubClassifyView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSubClassifyView.h"
#import "WGClassifyItem.h"

@interface WGSubClassifyView (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGSubClassifyView
{
    UIView *_contentView;
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    _contentView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _contentView.backgroundColor = kClearColor;
    _contentView.userInteractionEnabled = YES;
    [self addSubview:_contentView];
    [_contentView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleSingleTap:)];
    
    JHImageView *bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(88), kAppNavigationVCY, kAppAdaptWidth(200), kAppAdaptWidth(344))];
    bgImageView.image = [UIImage imageNamed:@"classifyDetail_sub_bg"];
    [self addSubview:bgImageView];
    bgImageView.clipsToBounds = YES;
    bgImageView.userInteractionEnabled = YES;
    
    JHTableView *tableView = [[JHTableView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(8), bgImageView.width, bgImageView.height - kAppAdaptHeight(8)) style:UITableViewStyleGrouped];
    tableView.layer.masksToBounds = YES;
    tableView.layer.cornerRadius = kAppAdaptWidth(6);
    tableView.backgroundColor = kClearColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgImageView addSubview:tableView];
}

- (void)handleSingleTap:(UIGestureRecognizer *)recognizer {
    [self close];
}

@end

@implementation WGSubClassifyView (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _classifyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = kAppAdaptFont(14);
        cell.textLabel.textColor = WGAppTitleColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(47), kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
        cell.backgroundColor = kClearColor;
    }
    WGClassifyItem *item = _classifyArray[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onApply) {
        self.onApply(_classifyArray[indexPath.row]);
    }
    [self close];
}

@end
