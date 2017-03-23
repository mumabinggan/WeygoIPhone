//
//  WGCommitOrderRemarkCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderRemarkCell.h"

@interface WGCommitOrderRemarkCell ()
{
    JHTextField *_textView;
}
@end

@implementation WGCommitOrderRemarkCell

- (void)loadSubviews {
    [super loadSubviews];
    _textView = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(48))];
    _textView.font = kAppAdaptFont(14);
    _textView.textColor = WGAppNameLabelColor;
    _textView.placeholder = kStr(@"CommitOrder Remark");
    [self.contentView addSubview:_textView];
}

- (NSString *)remark {
    return _textView.text;
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(48);
}

@end
