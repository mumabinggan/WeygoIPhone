//
//  WGShopCartViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartViewController.h"
#import "WGShopCartGoodItem.h"

@interface WGShopCartViewController (Request)

- (void)loadCheckFailureGood;

- (void)loadDeleteIndexPath:(NSIndexPath *)indexPath;

- (void)loadShopCartList:(BOOL)refresh pulling:(BOOL)pulling;

- (void)loadUpdateGood:(WGShopCartGoodItem *)item count:(NSInteger)count;

- (void)loadCleanShopCart;

@end
