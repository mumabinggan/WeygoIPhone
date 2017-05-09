//
//  WGHomeFloorGoodGridItemView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"
#import "WGHomeFloorGoodColumnItemView.h"

@interface WGHomeFloorGoodGridItemView : WGHomeFloorGoodColumnItemView
{
    WGHomeFloorContentGoodItem *_data;
}

@property (nonatomic, assign) BOOL displaySpecification;

@property (nonatomic, copy) void (^onPurchase)(WGHomeFloorContentGoodItem *item, CGPoint fromPoint);

@end
