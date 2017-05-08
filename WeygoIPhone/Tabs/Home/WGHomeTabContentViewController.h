//
//  WGHomeTabContentViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabBaseContentViewController.h"
#import "TWRefreshCollectionView.h"
#import "WGHome.h"

typedef NS_ENUM(NSInteger, WGConfigContentType) {
    WGConfigContentTypeHome,
    WGConfigContentTypeBenefit,
    WGConfigContentTypeAsia,
};

@interface WGHomeTabContentViewController : WGHomeTabBaseContentViewController

@property (nonatomic, copy) void (^onTopRefresh)();

@property (nonatomic, strong) WGHome *homeData;

@property (nonatomic, assign) TWRefreshType refreshType;

- (TWRefreshTableView *)tableView;

@end
