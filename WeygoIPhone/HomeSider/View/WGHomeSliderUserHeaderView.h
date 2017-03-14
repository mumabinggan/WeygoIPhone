//
//  WGSliderHeaderView.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGHomeSliderUserHeaderView : JHTableViewHeaderFooterView

@property (nonatomic, copy) void (^onLogin)();

@property (nonatomic, copy) void (^onScan)();

@property (nonatomic, copy) void (^onMessageCenter)();

+ (CGFloat)height;

@end
