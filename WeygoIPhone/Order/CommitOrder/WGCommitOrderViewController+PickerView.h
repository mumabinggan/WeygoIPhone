//
//  WGCommitOrderViewController+PickerView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController.h"

@interface WGCommitOrderViewController (PickerView) <UIPickerViewDelegate, UIPickerViewDataSource>

- (void)initPickerView:(int)tag;

@end
