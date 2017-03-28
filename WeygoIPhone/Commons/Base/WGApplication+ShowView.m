//
//  WGApplication+ShowView.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/27.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+ShowView.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@interface WGApplication (HUDDelegate)

@end

@implementation WGApplication (ShowView)

- (void)startLoadingViewWithMessage:(NSString *)loadingMessage{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self stopLoadingView:NO];
    HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.label.text = loadingMessage;
    HUD.delegate = self;
    [HUD showAnimated:YES];
}

- (void)stopLoadingView{
    [self stopLoadingView:YES];
}

- (void)stopLoadingView:(BOOL)animated{
    if(HUD){
        [HUD hideAnimated:animated];
    }
}

- (void)showMessage:(NSString *)message {
    [self showMessage:message onCompletion:nil];
}

- (void)showMessage:(NSString *)message onCompletion:(void(^)()) completion {
    [self showMessage:message autoCloseAfter:2 onCompletion:completion];
}

- (void)showMessage:(NSString *)message autoCloseAfter:(NSInteger) secondsDelay onCompletion:(void(^)()) completion {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideMessageView) object:nil];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!_messageView) {
        _messageView = [[JHView alloc] initWithFrame:CGRectMake(0, -64, kDeviceWidth, 64)];
        _messageView.backgroundColor = kRGBA(55, 55, 55, 0.95);
        [window addSubview:_messageView];
        
        JHLabel *messageLabel = [[JHLabel alloc] initWithFrame:CGRectInset(_messageView.bounds, 16, 16)];
        messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.font = kAppFont(14);
        messageLabel.textColor = kWhiteColor;
        messageLabel.tag = 100;
        [_messageView addSubview:messageLabel];
        
        JHView *v = [[JHView alloc] initWithFrame:CGRectMake((_messageView.frame.size.width-36)/2, _messageView.frame.size.height-10, 36, 6) radius:3];
        v.backgroundColor = kRGBA(255, 255, 255, 0.5);
        [_messageView addSubview:v];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNotificationViewPan:)];
        [_messageView addGestureRecognizer:panGesture];
    }
    JHLabel *messageLabel = (JHLabel*)[_messageView viewWithTag:100];
    if (messageLabel) {
        messageLabel.text = message;
    }
    if (completion) {
        objc_setAssociatedObject(_messageView, @"completionBlock", completion, OBJC_ASSOCIATION_COPY);
    }
    [self showMessageView];
}

- (void)showMessageView {
    CGRect r = _messageView.frame;
    r.origin.y = 0;
    [UIView animateWithDuration:0.30 animations:^{
        _messageView.frame = r;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideMessageView) withObject:nil afterDelay:2.0];
    }];
}

- (void)hideMessageView {
    CGRect r = _messageView.frame;
    r.origin.y = -r.size.height;
    [UIView animateWithDuration:0.30 animations:^{
        _messageView.frame = r;
        //_messageView.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        void(^completionBlock)() = objc_getAssociatedObject(_messageView, @"completionBlock");
        if (completionBlock) {
            completionBlock();
        }
        [_messageView removeFromSuperview];
        _messageView = nil;
    }];
}

@end

@implementation WGApplication (HUDDelegate)

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (HUD) {
        HUD = nil;
    }
}

@end

