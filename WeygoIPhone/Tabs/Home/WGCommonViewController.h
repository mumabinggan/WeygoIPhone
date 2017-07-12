//
//  WGCommonViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGSegmentView.h"
#import "WGHomeTabContentViewController.h"
#import "WGHomeTabTitleResponse.h"
#import "WGTitleItem.h"

typedef NS_ENUM(NSInteger, WGHomeCacheType) {
    WGHomeCacheTypeCacheBoth,
    WGHomeCacheTypeCachePrior,
    WGHomeCacheTypeCacheNetwork,
};

@interface WGCommonViewController : WGViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
    NSMutableDictionary *_tabContentMDictionary;
    //NSMutableDictionary *_tabDataMDictionary;
    //NSArray *_titleArray;
    //WGHomeTabTitleResponse *_titleResponse;
    
    WGHomeTabTitleResponse *_dataResponse;
    
    //Cache
    BOOL _hadReadTitlesCache;
    NSMutableDictionary *_hadReadContentCacheDictionary;
}

@property (nonatomic, assign) long long currentId;

- (long)menuIdWithIndex:(NSInteger)index;

- (WGTitleItem *)dataWithMenuId:(long)menuId;

- (NSInteger)indexWithMenuId:(long)menuId;

- (WGTitleItem *)dataWithIndex:(NSInteger)index;

@end
