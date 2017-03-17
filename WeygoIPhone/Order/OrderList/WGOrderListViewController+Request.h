//
//  WGOrderListViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListViewController.h"

@interface WGOrderListViewController (Request)

- (void)loadOrderList:(BOOL)refresh pulling:(BOOL)pulling;

@end
