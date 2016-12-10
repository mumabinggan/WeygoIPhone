//
//  WGHomeTabViewController+ScrollContents.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController.h"

@interface WGHomeTabViewController (ScrollContents)

- (void)addContentsScrollView;

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount;

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex;

@end
