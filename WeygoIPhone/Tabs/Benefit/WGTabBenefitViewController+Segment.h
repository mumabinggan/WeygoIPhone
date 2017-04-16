//
//  WGTabBenefitViewController+Segment.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController.h"

@interface WGTabBenefitViewController (Segment)

- (void)addTitleSegmentView;

- (void)setSelectedIndex:(NSInteger)index;

- (void)setTitleSegmentView:(NSArray *)titleArray;

@end
