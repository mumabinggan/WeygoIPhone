//
//  WGSidebarViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGHomeSlider.h"
#import "WGClassifyItem.h"

@interface WGHomeSliderViewController : WGViewController
{
    WGHomeSlider *_data;
}

@property (nonatomic, copy) void (^onTouchBlankArea)();

//@property (nonatomic, copy) void (^onApplyClassifyItem)(WGClassifyItem *item);

- (void)refresh;

- (void)refreshUI;

- (NSArray *)getSubArray:(NSInteger)count;

@end
