//
//  WGShopCartViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartViewController.h"

@interface WGShopCartViewController (Request)

- (void)handleDeleteIndexPath:(NSIndexPath *)indexPath;

- (void)loadShopCartList:(BOOL)refresh pulling:(BOOL)pulling;

@end
