//
//  WGBenefitTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGSegmentView.h"

@interface WGTabBenefitViewController : WGTabViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
    NSMutableDictionary *_tabContentMDictionary;
    //TWRefreshCollectionView *_collectionView;
}

@property (nonatomic, assign) long long currentId;

@end
