//
//  WGMessageItemCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageItemCell.h"
#import "TTTAttributedLabel.h"
#import "WGMessageItem.h"

@interface WGMessageItemCell ()
{
    JHLabel *_titleLabel;
    JHView *_readView;
    JHLabel *_timeLabel;
    TTTAttributedLabel *_contentLabel;
    WGMessageItem *_data;
}
@end

@interface WGMessageItemCell (AttributeLabelDelegate) <TTTAttributedLabelDelegate>

@end

@implementation WGMessageItemCell

- (void)loadSubviews {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(40))];
    headerView.backgroundColor = kHRGB(0xF8FAFA);
    [self.contentView addSubview:headerView];
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), headerView.height)];
    _titleLabel.font = kAppAdaptFont(14);
    _titleLabel.textColor = WGAppNameLabelColor;
    [headerView addSubview:_titleLabel];
    
    _readView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptHeight(8), kAppAdaptHeight(8)) radius:kAppAdaptHeight(4)];
    _readView.backgroundColor = WGAppBaseColor;
    _readView.hidden = YES;
    [headerView addSubview:_readView];
    
    _timeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), headerView.height)];
    _timeLabel.font = kAppAdaptFont(14);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = WGAppLightNameLabelColor;
    [headerView addSubview:_timeLabel];
    
    _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(15) + headerView.height, _titleLabel.width, 1)];
    _contentLabel.font = kAppAdaptFont(14);
    _contentLabel.numberOfLines = 0;
    _contentLabel.delegate = self;
    _contentLabel.textColor = WGAppTitleColor;
    _contentLabel.linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : @(NO), NSForegroundColorAttributeName : WGAppBlueButtonColor};
    _contentLabel.activeLinkAttributes = @{WGAppTitleColor:(NSString *)kCTForegroundColorAttributeName};
    [self.contentView addSubview:_contentLabel];
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, headerView.maxY, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
}

- (void)showWithData:(JHObject *)data {
    WGMessageItem *message = (WGMessageItem *)data;
    _data = message;
    if (message) {
        _titleLabel.text = message.title;
        _timeLabel.text = message.time;
        _readView.hidden = message.isRead;
        CGSize size = [message.title returnSize:_titleLabel.font maxWidth:kDeviceWidth - kAppAdaptWidth(30)];
        _readView.center = CGPointMake(kAppAdaptWidth(15) + size.width + kAppAdaptWidth(15), kAppAdaptHeight(20));
        
        _contentLabel.text = message.displayContent;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_contentLabel.attributedText];
        [attributedString setAttributes:@{NSForegroundColorAttributeName : WGAppBlueButtonColor} range:message.moreRange];
        NSURL *linkURL = [[NSURL alloc] initWithString:@"1"];
        [_contentLabel addLinkToURL:linkURL withRange:message.moreRange];
        
        size = [message.displayContent returnSize:_contentLabel.font maxWidth:kDeviceWidth - kAppAdaptWidth(30)];
        _contentLabel.height = size.height;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    CGFloat height = kAppAdaptHeight(40);
    WGMessageItem *message = (WGMessageItem *)data;
    if (message) {
        height += [message.displayContent returnSize:kAppAdaptFont(14) maxWidth:(kDeviceWidth - kAppAdaptWidth(30))].height + kAppAdaptHeight(30);
    }
    return height;
}

@end

@implementation WGMessageItemCell (AttributeLabelDelegate)

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url {
    if (self.onMore) {
        self.onMore(_data);
    }
}

@end
