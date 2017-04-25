//
//  AppDelegate+Zendesk.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "AppDelegate+Zendesk.h"
#import <ZDCChat/ZDCChat.h>

@implementation AppDelegate (Zendesk)

- (void)registerZendesk {
    [ZDCChat initializeWithAccountKey:@"your account key here"];
    [ZDCLog enable:YES];
    [ZDCLog setLogLevel:ZDCLogLevelWarn];
}

@end
