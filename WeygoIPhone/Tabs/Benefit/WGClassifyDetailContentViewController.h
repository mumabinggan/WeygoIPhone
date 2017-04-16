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

typedef NS_ENUM(NSInteger, WGClassifyDetailType) {
    WGClassifyDetailTypeNormal,
    WGClassifyDetailTypeCountry,
    WGClassifyDetailTypeBenefit,
};

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
}

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, assign) WGClassifyDetailType type;

@property (nonatomic, strong) void (^onResponse)(WGClassifyDetail *classifyDetail);

@property (nonatomic, copy) void (^onTopRefresh)();

- (void)refreshUI;

@end
