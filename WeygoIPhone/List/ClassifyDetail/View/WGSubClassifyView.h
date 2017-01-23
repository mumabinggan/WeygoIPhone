//
//  WGSubClassifyView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"

@class WGClassifyItem;

@interface WGSubClassifyView : JHPopoverView

@property (nonatomic, strong) NSArray *classifyArray;

@property (nonatomic, copy) void (^onApply)(WGClassifyItem *item);

@end
