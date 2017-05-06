//
//  WGCommitOrderFaxCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderFaxCell.h"
#import "WGReceipt.h"

@interface WGCommitOrderFaxCell ()
{
    JHLabel *_noDataLabel;
    JHLabel *_taxLabel;
    JHLabel *_companyLabel;
    JHLabel *_capLabel;
}
@end

@implementation WGCommitOrderFaxCell

- (void)loadSubviews {
    
    _taxLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(12), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(25))];
    _taxLabel.font = kAppAdaptFont(14);
    _taxLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_taxLabel];
    
    _companyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _taxLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(25))];
    _companyLabel.font = kAppAdaptFont(14);
    _companyLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_companyLabel];
    
    _capLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _companyLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(25))];
    _capLabel.font = kAppAdaptFont(14);
    _capLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_capLabel];
    
    _noDataLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(48))];
    _noDataLabel.font = kAppAdaptFont(14);
    _noDataLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_noDataLabel];
}

- (void)showWithData:(JHObject *)data {
    WGReceipt *receipt = (WGReceipt *)data;
    if (receipt) {
        _taxLabel.hidden = NO;
        _companyLabel.hidden = NO;
        _capLabel.hidden = NO;
        _noDataLabel.hidden = YES;
        _taxLabel.text = receipt.companyName;
        _companyLabel.text = receipt.address;
        _capLabel.text = receipt.taxCode;
    }
    else {
        _taxLabel.hidden = YES;
        _companyLabel.hidden = YES;
        _capLabel.hidden = YES;
        _noDataLabel.hidden = NO;
        _noDataLabel.text = kStr(@"CommitOrder Fax");
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    if (data) {
        return kAppAdaptHeight(100);
    }
    else {
        return kAppAdaptHeight(48);
    }
}

@end
