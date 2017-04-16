//
//  WGTabBenefitViewController+Scroll.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController.h"

@interface WGTabBenefitViewController (Scroll)

- (void)addContentsScrollView;

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount;

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex;

@end
