//
//  WGEvent.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KochavaTracker.h"

static NSString *kRegisterCompletionFromForm = @"Form";
static NSString *kRegisterCompletionFromWeChat = @"WeChat";
static NSString *kRegisterCompletionFromFacebook = @"Facebook";

@interface WGEvent : NSObject <KochavaTrackerDelegate>
{
    KochavaTracker *_kochavaTracker;
}

+ (WGEvent *)shareInstance;

- (void)test;

- (void)registerCompletion:(NSString *)userId from:(NSString *)from;

- (void)checkOutStart:(NSString *)userId sum:(NSString *)sum;

- (void)purchase:(NSString *)sum orderId:(NSString *)orderId;

@end
