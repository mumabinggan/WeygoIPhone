//
//  WGTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGTabViewController : WGViewController
{
    int _viewType;
}

@property (nonatomic, assign) WGTabIndex tabBarIndex;

@end
