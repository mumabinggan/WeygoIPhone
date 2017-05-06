//
//  LFServiceLoadingView.h
//  LiFang
//
//  Created by yanmingxin on 15/12/8.
//  Copyright © 2015年 Lifang. All rights reserved.
//

#import "JHView.h"

@interface WGServiceLoadingView : JHView

@property(nonatomic, copy) void (^stopView)();

- (void)startAnimation;

- (void)stopAnimation;

@end
