//
//  WGHomeTopicView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGTopicItem;

@interface WGHomeTopicItemView : JHView

@property (nonatomic, copy) void (^onApply)(WGTopicItem *item);

- (void)showWithData:(JHObject *)data;

@end
