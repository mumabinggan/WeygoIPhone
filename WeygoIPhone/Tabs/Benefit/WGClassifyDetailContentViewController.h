//
//  WGCommonClassifyDetailViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGClassifyDetail.h"
#import "WGClassifyFilterCondition.h"
#import "WGClassifyDetailResponse.h"

typedef NS_ENUM(NSInteger, WGClassifySortType) {
    WGClassifySortTypeDefault,
    WGClassifySortTypeBranch,
    WGClassifySortTypePriceDown,
    WGClassifySortTypePriceUp
};

@interface WGClassifyDetailContentViewController : WGViewController
{
    TWRefreshTableView *_tableView;
    WGClassifyFilterCondition *_filter;
    WGClassifyDetail *_data;
    
    WGClassifySortType _sortType;
    JHButton *_closeBtn;
    
    BOOL _isGrid;
    
    NSMutableDictionary *_hadReadContentCacheDictionary;
}

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, strong) void (^onResponse)(WGClassifyDetail *classifyDetail);

@property (nonatomic, copy) void (^onTopRefresh)();

- (void)refreshUI;

@end
