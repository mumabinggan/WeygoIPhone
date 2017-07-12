//
//  WGBenefitTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGSegmentView.h"
#import "WGBenefitTabResponse.h"

@interface WGTabBenefitViewController : WGTabViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
    NSMutableDictionary *_tabContentMDictionary;
    //NSArray *_titleArray;
    WGBenefitTabResponse *_dataResponse;
    BOOL _hadReadTitlesCache;
}

@property (nonatomic, assign) long long currentId;

@end
