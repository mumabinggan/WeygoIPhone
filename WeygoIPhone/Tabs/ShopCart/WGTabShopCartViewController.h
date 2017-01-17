//
//  WGForeignTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGShopCart.h"

@interface WGTabShopCartViewController : WGTabViewController
{
    WGShopCart *_data;
}

- (void)refreshTableView;

@end
