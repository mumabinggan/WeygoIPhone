//
//  WGClassifyDetailFilterViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@class WGClassifyFilterCondition;

@interface WGClassifyDetailFilterViewController : WGViewController
{
    WGClassifyFilterCondition *_data;
}

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, strong) WGClassifyFilterCondition *currentFilterCondition;

@property (nonatomic, copy) void (^onApply)(WGClassifyFilterCondition *filter);

- (void)refreshView;

@end
