//
//  WGCommitOrderViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGCommitOrderDetail.h"
#import "WGOverweightView.h"

@interface WGCommitOrderViewController : WGViewController
{
    JHTableView *_tableView;
    WGCommitOrderDetail *_commitOrderDetail;
    
    UIPickerView *_pickerView;
    
    JHView *_sortPickerBgView;
    JHButton *_closeBtn;
    
    WGOverweightView *_overWeightView;
    NSArray *_overWeightArray;
}

@property (nonatomic, assign) NSInteger settlementId;

- (void)refreshUI;

- (void)showOverWeightView;

@end
