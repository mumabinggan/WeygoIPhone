//
//  WGClassifyDetailViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGClassifyDetail.h"
#import "WGClassifyFilterCondition.h"

typedef NS_ENUM(NSInteger, WGClassifySortType) {
    WGClassifySortTypeDefault,
    WGClassifySortTypeBranch,
    WGClassifySortTypePriceDown,
    WGClassifySortTypePriceUp
};

@interface WGClassifyDetailViewController : WGViewController
{
    WGClassifyFilterCondition *_filter;
    WGClassifyDetail *_data;
    
    WGClassifySortType _sortType;
}

@property (nonatomic, assign) long long classifyId;

- (void)refreshUI;

@end
