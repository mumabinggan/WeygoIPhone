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
    WGHomeFloorGoodGridItemView *_firstItemView;
    WGHomeFloorGoodGridItemView *_secondItemView;
    NSArray *_dataArray;
}
@end

@implementation WGHomeFloorGoodGridItemCell

- (void)loadSubviews {
    self.backgroundColor = kRGB(247, 250, 250);
    WeakSelf;
    _firstItemView = [[WGHomeFloorGoodGridItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(8), kAppAdaptWidth(175), kAppAdaptHeight(312)) radius:kAppAdaptWidth(6)];
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
        
        [_firstItemView showWithData:array[0]];
    }
    
    if (array.count == 2) {
        _firstItemView.hidden = NO;
        _secondItemView.hidden = NO;
        
        [_firstItemView showWithData:array[0]];
        [_secondItemView showWithData:array[1]];
    }
}

- (void)handleClick:(UIGestureRecognizer *)recognizer {
    if (self.onApply) {
        if ([recognizer.view isEqual:_firstItemView]) {
            self.onApply((WGHomeFloorContentItem *)(_dataArray[0]));
        }
        else {
            self.onApply((WGHomeFloorContentItem *)_dataArray[1]);
        }
    }
}

- (void)handlePurchase:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint)fromPoint {
    if (self.onPurchase) {
        self.onPurchase(item, fromPoint);
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(320);
}

@end
