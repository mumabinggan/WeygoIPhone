//
//  WGHomeFloorGoodGridCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGHomeFloorContentItem.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGHomeFloorGoodGridItemView.h"

@interface WGHomeFloorGoodGridItemCell : JHTableViewCell
{
    WGHomeFloorGoodGridItemView *_firstItemView;
    WGHomeFloorGoodGridItemView *_secondItemView;
}

@property (nonatomic, copy) void (^onApply)(WGHomeFloorContentGoodItem *item);

@property (nonatomic, copy) void (^onPurchase)(WGHomeFloorContentGoodItem *object, CGPoint fromPoint);

@end
