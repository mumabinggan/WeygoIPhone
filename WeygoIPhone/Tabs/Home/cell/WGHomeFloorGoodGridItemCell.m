//
//  WGHomeFloorGoodGridCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodGridItemCell.h"
#import "WGHomeFloorGoodGridItemView.h"

@interface WGHomeFloorGoodGridItemCell ()
{
    NSArray *_dataArray;
}
@end

@implementation WGHomeFloorGoodGridItemCell

- (void)loadSubviews {
    self.backgroundColor = kRGB(247, 250, 250);
    WeakSelf;
    _firstItemView = [[WGHomeFloorGoodGridItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(8), kAppAdaptWidth(175), [WGHomeFloorGoodGridItemCell heightWithArray:nil] - kAppAdaptHeight(8)) radius:kAppAdaptWidth(6)];
    _firstItemView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:_firstItemView];
    _firstItemView.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
        [weakSelf handlePurchase:item fromPoint:fromPoint];
    };
    [_firstItemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
    
    _secondItemView = [[WGHomeFloorGoodGridItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16 + 175), kAppAdaptWidth(8), kAppAdaptWidth(175), kAppAdaptHeight(312)) radius:kAppAdaptWidth(6)];
    _secondItemView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:_secondItemView];
    _secondItemView.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
        [weakSelf handlePurchase:item fromPoint:fromPoint];
    };
    [_secondItemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
}

- (void)showWithArray:(NSArray *)array {
    _dataArray = array;
    if (array.count == 0) {
        _firstItemView.hidden = YES;
        _secondItemView.hidden = YES;
        return;
    }
    
    if (array.count == 1) {
        _firstItemView.hidden = NO;
        _secondItemView.hidden = YES;
        WGHomeFloorContentGoodItem *item = nil;
        if ([array[0] isKindOfClass:[WGHomeFloorContentGoodItem class]]) {
            item = array[0];
        }
        else if ([array[0] isKindOfClass:[WGHomeFloorContentItem class]]) {
            WGHomeFloorContentItem *contentItem0 = array[0];
            item = (WGHomeFloorContentGoodItem *)[contentItem0 contentItemWithType:WGHomeFloorItemTypeGoodGrid];
        }
        [_firstItemView showWithData:item];
    }
    
    if (array.count == 2) {
        _firstItemView.hidden = NO;
        _secondItemView.hidden = NO;
        WGHomeFloorContentGoodItem *item0 = nil;
        WGHomeFloorContentGoodItem *item1 = nil;
        if ([array[0] isKindOfClass:[WGHomeFloorContentGoodItem class]]) {
            item0 = array[0];
            item1 = array[1];
        }
        else if ([array[0] isKindOfClass:[WGHomeFloorContentItem class]]) {
            WGHomeFloorContentItem *contentItem0 = array[0];
            item0 = (WGHomeFloorContentGoodItem *)[contentItem0 contentItemWithType:WGHomeFloorItemTypeGoodGrid];
            
            WGHomeFloorContentItem *contentItem1 = array[1];
            item1 = (WGHomeFloorContentGoodItem *)[contentItem1 contentItemWithType:WGHomeFloorItemTypeGoodGrid];
        }
        [_firstItemView showWithData:item0];
        [_secondItemView showWithData:item1];
    }
}

- (void)handleClick:(UIGestureRecognizer *)recognizer {
    if (self.onApply) {
        int index = 0;
        if ([recognizer.view isEqual:_firstItemView]) {
            index = 0;
        }
        else {
            index = 1;
        }
        WGHomeFloorContentGoodItem *item = nil;
        if ([_dataArray[index] isKindOfClass:[WGHomeFloorContentGoodItem class]]) {
            item = _dataArray[index];
        }
        else if ([_dataArray[index] isKindOfClass:[WGHomeFloorContentItem class]]) {
            WGHomeFloorContentItem *contentItem0 = _dataArray[index];
            item = (WGHomeFloorContentGoodItem *)[contentItem0 contentItemWithType:WGHomeFloorItemTypeGoodGrid];
        }
        self.onApply(item);
    }
}

- (void)handlePurchase:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint)fromPoint {
    if (self.onPurchase) {
        self.onPurchase(item, fromPoint);
    }
}

+ (CGFloat)heightWithArray:(NSArray *)array {
    return kAppAdaptHeight(320);
}

@end
