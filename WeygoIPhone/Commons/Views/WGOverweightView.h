//
//  WGOverweightView.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"
#import "WGOverHeightDetail.h"

@interface WGOverweightView : JHPopoverView

@property (nonatomic, copy) void (^onConfirm)(NSArray *data);

@property (nonatomic, copy) void (^onDelete)(NSArray *data);

- (id)initWithFrame:(CGRect)frame overHeightDetail:(NSArray *)detail;

@end
