//
//  WGOrderCountView.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderCountView.h"

@interface WGOrderCountView ()
{
    JHLabel *_label;
}
@end

@implementation WGOrderCountView

- (void)loadSubviews {
    _label = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _label.font = kAppAdaptFont(10);
    _label.layer.cornerRadius = kAppAdaptHeight(12);
    _label.layer.masksToBounds = YES;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = WGAppBlueButtonColor;
    _label.textColor = kWhiteColor;
    [self addSubview:_label];
}

- (void)setValue:(NSString *)value {
    _value = value;
    _label.text = value;
}

@end
