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
    [ZDCChat initializeWithAccountKey:@"3posW2IznifTuXsiwtKNJ2u6Su8uXDiG"];
    [ZDCLog enable:YES];
    [ZDCLog setLogLevel:ZDCLogLevelWarn];
}

@end
