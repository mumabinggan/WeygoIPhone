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
    
    _closeBtn = [[JHButton alloc] initWithFrame:self.view.bounds];
    [_closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn setBackgroundColor:kHRGBA(0x000000, 0.5)];
    [self.view addSubview:_closeBtn];
    
    _sortPickerBgView = [[JHView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kAppAdaptHeight(300), kDeviceWidth, kAppAdaptHeight(300))];
    _sortPickerBgView.backgroundColor = kWhiteColor;
    [self.view addSubview:_sortPickerBgView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(60), kDeviceWidth, kAppAdaptHeight(200))];
    pickerView.backgroundColor = kRGB(244, 244, 244);
    pickerView.tag = tag;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    if (pickerView.tag == 1000) {
        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
        for (int num = 0; num < dates.count; ++num) {
            WGSettlementDate *item = dates[num];
            if ([item.id isEqualToString:_commitOrderDetail.deliverTime.currentDateId]) {
                [pickerView selectRow:num inComponent:0 animated:NO];
                break;
            }
        }
    }
    else if (pickerView.tag == 1001) {
        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
        for (int num = 0; num < times.count; ++num) {
            WGSettlementTime *item = times[num];
            if ([item.id isEqualToString:_commitOrderDetail.deliverTime.currentTimeId]) {
                [pickerView selectRow:num inComponent:0 animated:NO];
                break;
            }
        }
    }
    else if (pickerView.tag == 1002) {
        if (_commitOrderDetail && _commitOrderDetail.payMothod) {
            NSArray *payMethods = _commitOrderDetail.payMothod.payMethods;
            for (int num = 0; num < payMethods.count; ++num) {
                WGSettlementPayMethod *item = payMethods[num];
                if ([item.id isEqualToString:_commitOrderDetail.payMothod.currentPayId]) {
                    [pickerView selectRow:num inComponent:0 animated:NO];
                    break;
                }
            }
        }
    }
    _pickerView = pickerView;
    [_sortPickerBgView addSubview:pickerView];
    
    _sortPickerBgView.backgroundColor = _pickerView.backgroundColor;
    
    NSString *titleString = kStr(@"Mine_Logout_Cancel");
    float width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
    JHButton *cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
    [cancelBtn setTitle:titleString forState:UIControlStateNormal];
    [cancelBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = kAppAdaptFont(16);
    [_sortPickerBgView addSubview:cancelBtn];
    
    titleString = kStr(@"Mine_Logout_Ok");
    width = [titleString returnSize:kAppAdaptFont(16)].width + kAppAdaptWidth(10);
    JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - width - kAppAdaptWidth(8), kAppAdaptWidth(10), width, kAppAdaptHeight(30))];
    [confirmBtn setTitle:titleString forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WGAppBaseColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = kAppAdaptFont(16);
    [_sortPickerBgView addSubview:confirmBtn];
    
    _pickerView = pickerView;
}

- (void)touchCancelBtn:(JHButton *)sender {
    [self removePickerView];
}

- (void)removePickerView {
    [_sortPickerBgView removeFromSuperview];
    _sortPickerBgView = nil;
    [_pickerView removeFromSuperview];
    _pickerView = nil;
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

- (void)touchConfirmBtn:(JHButton *)sender {
    NSInteger row = [_pickerView selectedRowInComponent:0];
    if (_pickerView.tag == 1000) {
        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
        WGSettlementDate *item = dates[row];
        _commitOrderDetail.deliverTime.currentDateId = item.id;
        _commitOrderDetail.deliverTime.currentTimeId = @"";
    }
    else if (_pickerView.tag == 1001) {
        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
        WGSettlementTime *item = times[row];
        _commitOrderDetail.deliverTime.currentTimeId = item.id;
    }
    else if (_pickerView.tag == 1002) {
        NSArray *payMethods = _commitOrderDetail.payMothod.payMethods;
        WGSettlementPayMethod *item = payMethods[row];
        _commitOrderDetail.payMothod.currentPayId = item.id;
    }
    [self refreshUI];
    [self removePickerView];
}

- (void)touchCloseBtn:(JHButton *)sender {
    [UIView animateWithDuration:0.3 animations:^() {
        _sortPickerBgView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [_sortPickerBgView removeFromSuperview];
            _sortPickerBgView = nil;
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

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kAppAdaptHeight(40);
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
//    if (pickerView.tag == 1000) {
//        NSArray *dates = _commitOrderDetail.deliverTime.deliverTimes;
//        WGSettlementDate *item = dates[row];
//        _commitOrderDetail.deliverTime.currentDateId = item.id;
//        _commitOrderDetail.deliverTime.currentTimeId = @"";
//    }
//    else if (pickerView.tag == 1001) {
//        NSArray *times = _commitOrderDetail.deliverTime.currentTimes;
//        WGSettlementTime *item = times[row];
//        _commitOrderDetail.deliverTime.currentTimeId = item.id;
//    }
//    else if (pickerView.tag == 1002) {
//        NSArray *payMethods = _commitOrderDetail.payMothod.payMethods;
//        WGSettlementPayMethod *item = payMethods[row];
//        _commitOrderDetail.payMothod.currentPayId = item.id;
//    }
//    [self refreshUI];
}

@end
