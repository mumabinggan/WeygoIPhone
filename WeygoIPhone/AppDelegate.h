//
//  AppDelegate.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    WGNavigationController *_rootVC;
}

@property (strong, nonatomic) UIWindow *window;

@end

