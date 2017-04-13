//
//  WGOrderPayCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderPayCell.h"
#import "WGOrderDetail.h"

@interface WGOrderPayCell ()
{
    NSArray *_data;
}
@end

@implementation WGOrderPayCell

- (void)showWithArray:(NSArray *)array {
    if (_data) {
        return;
    }
    _data = array;
    for (int num = 0; num < array.count; ++num) {
        JHLabel *label = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), num * kAppAdaptHeight(20) + kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
        label.font = kAppAdaptFont(14);
        label.textColor = WGAppTitleColor;
        label.text = array[num];
        [self.contentView addSubview:label];
    }
}

+ (CGFloat)heightWithArray:(NSArray *)data {
    if (data) {
        return kAppAdaptHeight(32) + data.count * kAppAdaptHeight(20);
    }
    return 0;
}

@end
