//
//  WGCommitOrderViewController+PickerView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController+PickerView.h"

@implementation WGCommitOrderViewController (PickerView)

- (void)initPickerView:(int)tag {
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(130), kDeviceWidth, kAppAdaptHeight(130))];
    pickerView.backgroundColor = kRGB(244, 244, 244);
    pickerView.tag = tag;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
}

- (void)touchCloseBtn:(JHButton *)sender {
    [UIView animateWithDuration:0.3 animations:^() {
        _pickerView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [_pickerView removeFromSuperview];
            _pickerView = nil;
        }
    }];
    [sender removeFromSuperview];
    sender = nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
        return dates.count;
    }
    else if (pickerView.tag == 1001) {
        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
        return times.count;
    }
    else if (pickerView.tag == 1002) {
        return _commitOrderDetail.payMothod.payMethods.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
        WGSettlementDate *item = dates[row];
        return [NSString stringWithFormat:@"%@  %@", item.week, item.date];
    }
    else if (pickerView.tag == 1001) {
        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
        WGSettlementTime *item = times[row];
        return item.time;
    }
    else if (pickerView.tag == 1002) {
        NSArray *payMethods = _commitOrderDetail.payMothod.payMethods;
        WGSettlementPayMethod *item = payMethods[row];
        return item.name;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1000) {
        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
        WGSettlementDate *item = dates[row];
        _commitOrderDetail.deliverTime.currentDateId = item.id;
        _commitOrderDetail.deliverTime.currentTimeId = @"";
    }
    else if (pickerView.tag == 1001) {
        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
        WGSettlementTime *item = times[row];
        _commitOrderDetail.deliverTime.currentTimeId = item.id;
    }
    else if (pickerView.tag == 1002) {
        NSArray *payMethods = _commitOrderDetail.payMothod.payMethods;
        WGSettlementPayMethod *item = payMethods[row];
        _commitOrderDetail.payMothod.currentPayId = item.id;
    }
    [self refreshUI];
}

@end
