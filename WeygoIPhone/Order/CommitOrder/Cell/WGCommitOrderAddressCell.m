//
//  WGCommiteOrderAddressCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderAddressCell.h"
#import "WGAddress.h"

@interface WGCommitOrderAddressCell ()
{
    JHImageView *_bgImageView;
    JHLabel *_nameLabel;
}
@end

@implementation WGCommitOrderAddressCell

- (void)loadSubviews {
    [super loadSubviews];
    
    _bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, [WGCommitOrderAddressCell heightWithData:nil])];
    _bgImageView.image = [UIImage imageNamed:@"commitOrder_address_bg"];
    [self.contentView addSubview:_bgImageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(56), 0, kDeviceWidth - kAppAdaptWidth(56 + 40), kAppAdaptHeight(80))];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.numberOfLines = 2;
    _nameLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGAddress *address = (WGAddress *)data;
    if (address) {
        _nameLabel.hidden = NO;
        NSMutableString *nameString = [[NSMutableString alloc] init];
        [nameString appendString:[NSString safeString:address.name]];
        if (![NSString isNullOrEmpty:address.name]) {
            [nameString appendString:@"   "];
        }
        [nameString appendString:[NSString safeString:address.address]];
        if (![NSString isNullOrEmpty:address.address]) {
            [nameString appendString:@"   "];
        }
        [nameString appendString:[NSString safeString:address.cap]];
        if (![NSString isNullOrEmpty:address.cap]) {
            [nameString appendString:@"   "];
        }
        [nameString appendString:[NSString safeString:address.phone]];
        if (![NSString isNullOrEmpty:address.phone]) {
            [nameString appendString:@"   "];
        }
        _nameLabel.text = nameString;
        if ([nameString returnSize:_nameLabel.font maxWidth:kDeviceWidth].width > _nameLabel.width) {
            [_nameLabel setLineSpace:10];
        }
        else {
            [_nameLabel setLineSpace:0];
        }
    }
    else {
        _nameLabel.hidden = YES;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(80);
}

@end
