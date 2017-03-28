//
//  WGApplication+ShowView.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/27.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"

@interface WGApplication (ShowView)<MBProgressHUDDelegate>

- (void)showMessage:(NSString *)message;

- (void)showMessage:(NSString *)message onCompletion:(void(^)()) completion;

- (void)showMessage:(NSString *)message autoCloseAfter:(NSInteger) secondsDelay onCompletion:(void(^)()) completion;

@end
