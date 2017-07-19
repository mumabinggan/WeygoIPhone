//
//  WGGoodDetailViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGGoodDetail.h"

@interface WGGoodDetailViewController : WGViewController
{
    JHTableView *_tableView;
    WGGoodDetail *_goodDetail;
    NSArray *_recommendGoods;
}

@property (nonatomic, assign) long long goodId;

- (void)refreshUI;

- (void)refreshBottomView;

@end
