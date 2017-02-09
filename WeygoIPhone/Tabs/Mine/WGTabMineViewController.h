//
//  WGMineTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGMine.h"

@interface WGTabMineViewController : WGTabViewController
{
    WGMine *_data;
}

- (void)refresh;

@end
