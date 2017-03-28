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
{
    //WGHome *_homeData;
}

@property (nonatomic, copy) void (^onTopRefresh)();

@property (nonatomic, assign) WGConfigContentType type;

@property (nonatomic, strong) WGHome *homeData;

@end
