//
//  WGDeliverPriceView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"

@interface WGDeliverPriceView : JHPopoverView

@property (nonatomic, copy) void (^onApply)(NSInteger index);

@property (nonatomic, strong) NSString *tip;

@end
