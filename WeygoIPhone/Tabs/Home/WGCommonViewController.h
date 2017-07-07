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

@interface WGCommonViewController : WGViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
    NSMutableDictionary *_tabContentMDictionary;
    NSMutableDictionary *_tabDataMDictionary;
    NSArray *_titleArray;
    WGHomeTabTitleResponse *_titleResponse;
}

@property (nonatomic, assign) long long currentId;

@end
