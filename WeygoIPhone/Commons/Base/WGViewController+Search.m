//
//  WGViewController+Search.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController+Search.h"
#import "WGSearchViewController.h"
#import <objc/runtime.h>
#import "WGApplication+Controller.h"

static const NSString *WGSearchButtonKey = @"WGSearchButtonKey";

@implementation WGViewController (Search)

- (UIBarButtonItem *)rightItem {
    return objc_getAssociatedObject(self, &WGSearchButtonKey);
}

- (void)setRightItem:(UIBarButtonItem *)rightItem {
    objc_setAssociatedObject(self, &WGSearchButtonKey, rightItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarButtonItem *)createSearchItem {
    if (!self.rightItem) {
        JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
        [backButton setTitle:nil forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(touchSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
        [backButton sizeToFit];
        CGRect r = backButton.frame;
        r.size.height = 44;
        r.size.width += 3;
        backButton.frame = r;
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        JHBarButtonItem *item =  [[JHBarButtonItem alloc] initWithCustomView:backButton];
        [item showBadge:([WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO) withNumber:(int)[WGApplication sharedApplication].shopCartGoodCount withFrame:CGRectMake(13, 5, 15, 15)];
        self.rightItem = item;
    }
    return self.rightItem;
}

- (void)touchSearchButton:(JHButton *)sender {
    WGSearchViewController *vc = [[WGSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
