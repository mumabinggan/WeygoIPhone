//
//  WGHomeTitleView.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGHomeTitleView : JHView

@property (nonatomic, copy) void (^onTouch)(WGHomeTitleView *item);

- (void)setTitle:(NSString *)title;

@end
