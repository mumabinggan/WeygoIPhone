//
//  WGViewController+TopButton.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/24.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGViewController (TopButton)

- (JHButton *)createTopButton;

- (void)showTopButton:(BOOL)show;

- (void)scrollToTop;

@end
