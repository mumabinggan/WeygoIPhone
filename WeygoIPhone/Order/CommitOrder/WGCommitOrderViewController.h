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
#import "WGOrderExpireGoodView.h"

@interface WGCommitOrderViewController : WGViewController
{
    JHTableView *_tableView;
    WGCommitOrderDetail *_commitOrderDetail;
    
    UIPickerView *_pickerView;
    
    JHView *_sortPickerBgView;
    JHButton *_closeBtn;
    
    WGOverweightView *_overWeightView;
    NSArray *_overWeightArray;
    
    WGOrderExpireGoodView *_expireGoodView;
}

@property (nonatomic, assign) NSInteger settlementId;

- (void)refreshUI;

- (void)showOverWeightView;

- (void)showExpireGood:(WGOrderExpireGood *)expireGood;

@end
