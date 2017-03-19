//
//  WGMessageCenterViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGMessageRequest.h"

@interface WGMessageCenterViewController : WGViewController
{
    WGMessageTabType _currentTabType;
    
    TWRefreshTableView *_tableView;
    NSMutableArray *_allMArray;
    NSMutableArray *_newMArray;
    NSMutableArray *_deliverMArray;
    NSArray *_currentArray;
}

- (void)refreshUI;

@end
