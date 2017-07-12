//
//  WGCommonViewController+Scroll.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController.h"

@interface WGCommonViewController (Scroll)

- (void)setContentsScrollView;

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount;

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex;

@end
