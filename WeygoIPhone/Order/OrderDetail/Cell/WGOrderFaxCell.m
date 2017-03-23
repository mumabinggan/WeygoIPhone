//
//  WGOrderFaxCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderFaxCell.h"
#import "WGOrderDetail.h"

@interface WGOrderFaxCell ()
{
    JHLabel *_taxLabel;
    JHLabel *_companyLabel;
    JHLabel *_capLabel;
}
@end

@implementation WGOrderFaxCell

- (void)loadSubviews {
    _taxLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _taxLabel.font = kAppAdaptFont(14);
    _taxLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_taxLabel];
    
    _companyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _taxLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _companyLabel.font = kAppAdaptFont(14);
    _companyLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_companyLabel];
    
    _capLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _companyLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _capLabel.font = kAppAdaptFont(14);
    _capLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_capLabel];
}

- (void)showWithData:(JHObject *)data {
    WGOrderFax *fax = ((WGOrderDetail *)data).fax;
    if (fax) {
        _taxLabel.text = [NSString stringWithFormat:kStr(@"Order Tax Number"), fax.taxCode];
        _companyLabel.text = [NSString stringWithFormat:kStr(@"Order Company"), fax.companyName];
        _capLabel.text = [NSString stringWithFormat:kStr(@"Order CAP"), fax.cap];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(92);
}

@end
