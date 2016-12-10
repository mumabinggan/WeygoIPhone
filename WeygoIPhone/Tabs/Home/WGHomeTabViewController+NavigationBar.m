//
//  WGHomeTabViewController+NavigationBar.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+NavigationBar.h"

@implementation WGHomeTabViewController (NavigationBar)

- (void)initNavigationItems {
    //set home titleView
    JHButton *titleButton = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(100), kAppNavigationBarHeight)];
    UIImage *image = [UIImage imageNamed:@"test"];
    [titleButton setTitle:kStr(@"米兰") forState:UIControlStateNormal];
    [titleButton setImage:image forState:UIControlStateNormal];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(image.width + 3), 0, (image.width + 3))];
    CGFloat labelWidth = [titleButton.titleLabel.text returnSize:titleButton.titleLabel.font].width;
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth + 3, 0, -(labelWidth + 3))];
    self.navigationItem.titleView = titleButton;
    
    //
}

@end
