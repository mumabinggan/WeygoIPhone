//
//  WGViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHViewController.h"
#import "WGViewController.h"

@interface WGViewController : JHViewController
{
    WGLoginType _loginType;
}
@end

@interface WGViewController (Login)

@property (nonatomic, assign) WGLoginType loginType;

- (void)handleLoginSuccess:(id)customData;

- (void)handleLoginCancel:(id)customData;

- (void)openLoginViewController;

- (void)openLoginViewControllerWithData:(id)data;

- (void)pushViewControllerAfterLogin:(UIViewController *)viewController;

@end

