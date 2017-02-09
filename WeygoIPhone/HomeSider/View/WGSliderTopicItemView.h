//
//  WGSliderTopicItemView.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"
#import "WGTopicItem.h"

@interface WGSliderTopicItemView : JHView

@property (nonatomic, copy) void (^onApply)(WGTopicItem *item);

- (void)showWithData:(JHObject *)data;

@end
