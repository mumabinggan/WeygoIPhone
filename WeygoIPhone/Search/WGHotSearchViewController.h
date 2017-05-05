//
//  WGHotSearchViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGHotSearchViewController : WGViewController
{
    NSArray *_hotArray;
    NSArray *_historyArray;
}

- (void)refreshHistory;

@end
