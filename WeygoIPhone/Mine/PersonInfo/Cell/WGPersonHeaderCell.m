//
//  WGPersonHeaderCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPersonHeaderCell.h"

@implementation WGPersonHeaderCell

- (void)loadSubviews {
    [super loadSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _headerImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(56), kAppAdaptHeight(56))];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = kAppAdaptWidth(28);
    self.accessoryView = _headerImageView;
}

- (void)showWithData:(JHObject *)data {
    NSString *imageName = (NSString *)data;
    _headerImageView.image = [UIImage imageNamed:imageName];
}

@end
