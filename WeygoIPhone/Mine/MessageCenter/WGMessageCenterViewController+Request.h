//
//  WGMessageCenterViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageCenterViewController.h"

@interface WGMessageCenterViewController (Request)

- (void)loadMessageList:(BOOL)refresh pulling:(BOOL)pulling;

- (void)loadMessageDetail:(long long)messageId;

- (void)loadDeleteMessage:(long long)messageId;

@end
