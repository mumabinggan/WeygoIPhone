//
//  WGSearchViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGSearchResponse.h"
#import "WGHotSearchViewController.h"

@interface WGSearchViewController : WGViewController
{
    TWRefreshTableView *_tableView;
    WGSearchData *_data;
    
    WGHotSearchViewController *_hotSearchViewController;
    
    JHTextField *_textFiled;
    
    NSString *_currentSearchString;
}

@property (nonatomic, strong) NSString *name;

- (void)refreshUI;

@end
