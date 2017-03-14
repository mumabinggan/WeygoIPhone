//
//  WGViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import <objc/runtime.h>
#import "WGLoginViewController.h"

@interface WGViewController ()

@end

@implementation WGViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkNavigationBarHidden];
}

- (void)checkNavigationBarHidden {
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:[self prefersNavigationBarHidden] animated:[self prefersNavigationBarHiddenAnimated]];
    }
}

- (BOOL)prefersNavigationBarHidden {
    return NO;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self initSubView];
    
    [self initNotification];
}

- (void)initData {
    
}

- (void)initSubView {
    
}

- (void)initNotification {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

static const NSString *WGLoginTypeKey = @"";
static const NSString *WGLoginCustomDataKey = @"";

@implementation WGViewController (Login)

- (void)setLoginType:(WGLoginType)loginType {
    if (loginType == WGLoginTypeNormal) {
        objc_setAssociatedObject(self, &WGLoginTypeKey, [NSNumber numberWithInteger:loginType], OBJC_ASSOCIATION_RETAIN);
    }
    else {
        objc_setAssociatedObject(self, &WGLoginTypeKey, nil, OBJC_ASSOCIATION_COPY);
    }
}

- (WGLoginType)loginType {
    NSNumber *number = objc_getAssociatedObject(self, &WGLoginTypeKey);
    if (number) {
        return number.integerValue;
    }
    return WGLoginTypeNormal;
}

- (void)setLoginCustomData:(id)data {
    objc_setAssociatedObject(self, &WGLoginCustomDataKey, data, OBJC_ASSOCIATION_RETAIN);
}

- (id)loginCustomData {
    return objc_getAssociatedObject(self, &WGLoginCustomDataKey);
}

- (void)openLoginViewController {
    [self openLoginViewControllerWithData:nil];
}

- (void)openLoginViewControllerWithData:(id)data {
    __weak typeof(self) weakSelf = self;
    [self setLoginCustomData:data];
    [self openLoginViewController:^(WGLoginViewController *viewController) {
        [weakSelf handleLoginSuccess];
    } cancel:^(WGLoginViewController *viewController) {
        [weakSelf handleLoginCancel];
    }];
}

- (void)openLoginViewController:(WGLoginSuccessBlock)successBlock cancel:(WGLoginCancelBlock)cancelBlock {
    [WGLoginViewController pushInNavigationController:self.navigationController sucess:successBlock cancel:cancelBlock];
}

- (void)handleLoginSuccess {
    [self handleLoginSuccess:[self loginCustomData]];
}

- (void)handleLoginSuccess:(id)customData {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleLoginCancel {
    [self handleLoginCancel:[self loginCustomData]];
}

- (void)handleLoginCancel:(id)customData {
    self.loginType = WGLoginTypeNormal;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushViewControllerAfterLogin:(UIViewController *)viewController {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers removeLastObject];
    [viewControllers addObject:viewController];
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

@end
