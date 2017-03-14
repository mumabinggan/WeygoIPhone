//
//  WGSliderClassifyItemCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSliderClassifyItemCell.h"
#import "WGClassifyItem.h"

@interface WGSliderClassifyItemCell ()
{
    JHLabel *_nameLabel;
}
@end

@implementation WGSliderClassifyItemCell

- (void)loadSubviews {
    self.backgroundColor = kWhiteColor;
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(40), 0, kAppAdaptWidth(240), kAppAdaptHeight(40))];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGClassifyItem *item = (WGClassifyItem *)data;
    _nameLabel.text = item.name;
}

@end
