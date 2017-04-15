//
//  WGHomeFloorTextHeadCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorNameAndBriefInfoHeadCell.h"
#import "WGHomeFloorItem.h"

@interface WGHomeFloorNameAndBriefInfoHeadCell ()
{
    JHLabel *_nameLabel;
    JHLabel *_briefInfoLabel;
}
@end

@implementation WGHomeFloorNameAndBriefInfoHeadCell

- (void)loadSubviews {
    [super loadSubviews];
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(12), kDeviceWidth, kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFontBold(16);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [self.contentView addSubview:_nameLabel];
    _nameLabel.hidden = YES;
    
    _briefInfoLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _nameLabel.maxY +  kAppAdaptHeight(4), kDeviceWidth, kAppAdaptHeight(20))];
    _briefInfoLabel.font = kAppAdaptFontBold(14);
    _briefInfoLabel.textAlignment = NSTextAlignmentCenter;
    _briefInfoLabel.textColor = kRGBA(0, 0, 0, 0.54);
    [self.contentView addSubview:_briefInfoLabel];
    _briefInfoLabel.hidden = YES;
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorItem *item = (WGHomeFloorItem *)data;
    if (item.onlyName) {
        //self.textLabel.text = item.name;
        _nameLabel.hidden = NO;
        _nameLabel.text = item.name;
        _briefInfoLabel.hidden = YES;
    }
    else {
        self.textLabel.text = nil;
        _nameLabel.hidden = NO;
        _briefInfoLabel.hidden = NO;
        _nameLabel.text = item.name;
        _briefInfoLabel.text = item.breifDescription;
    }
}

@end
