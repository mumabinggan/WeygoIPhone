//
//  WGCountdownTimeView.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGCountdownTimeView : JHView

@property (nonatomic, copy) void (^onHidden)();

- (void)setTime:(long long)time;

@end
