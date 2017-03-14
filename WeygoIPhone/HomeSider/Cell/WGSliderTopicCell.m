//
//  WGSliderTopicCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSliderTopicCell.h"
#import "WGSliderTopicItemView.h"

@interface WGSliderTopicCell ()
{
    WGSliderTopicItemView *_firstItemView;
    WGSliderTopicItemView *_secondItemView;
    NSArray *_dataArray;
}
@end

@implementation WGSliderTopicCell

- (void)loadSubviews {
    self.backgroundColor = kWhiteColor;
    _firstItemView = [[WGSliderTopicItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(8), kAppAdaptWidth(128), kAppAdaptHeight(64)) radius:kAppAdaptWidth(6)];
    _firstItemView.backgroundColor = kHRGB(0xF8FAFA);
    [self.contentView addSubview:_firstItemView];
    [_firstItemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
    
    _secondItemView = [[WGSliderTopicItemView alloc] initWithFrame:CGRectMake(_firstItemView.maxX + kAppAdaptWidth(8), _firstItemView.y, _firstItemView.width, _firstItemView.height) radius:_firstItemView.radius];
    _secondItemView.backgroundColor = kHRGB(0xF8FAFA);
    [self.contentView addSubview:_secondItemView];
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
            self.onApply((WGTopicItem *)(_dataArray[0]));
        }
        else {
            self.onApply((WGTopicItem *)_dataArray[1]);
        }
    }
}

@end
