//
//  WGMineTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGUser.h"

@interface WGTabMineViewController : WGTabViewController
{
    WGUser *_data;
}

- (void)refresh:(WGUser *)user;

@end
