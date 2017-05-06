//
//  LFWelcomeView.h
//  LiFang
//
//  Created by Chris on 18/5/15.
//  Copyright (c) 2015 Lifang. All rights reserved.
//

#import "JHView.h"

@interface WGWelcomeView : JHView

@property (nonatomic, copy) void (^onCompletion)();

- (void)stopAnimation;

- (void)startAnimation;

@end
