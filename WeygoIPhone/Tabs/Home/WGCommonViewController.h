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

@interface WGCommonViewController : WGViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
    NSMutableDictionary *_tabContentMDictionary;
    NSMutableDictionary *_tabDataMDictionary;
    NSArray *_titleArray;
}

@property (nonatomic, assign) WGConfigContentType type;

@property (nonatomic, assign) long long currentId;

@end
