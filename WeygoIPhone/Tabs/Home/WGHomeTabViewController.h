//
//  WGHomeTabViewController.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"

@class WGSegmentView;

@interface WGHomeTabViewController : WGTabViewController
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
}
@end
