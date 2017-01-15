//
//  WGHomeFloorClassifyGridCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorClassifyGridItemCell.h"
#import "WGHomeFloorClassifyGridView.h"

@interface WGHomeFloorClassifyGridItemCell ()
{
    NSArray *_itemViewArray;
    NSArray *_dataArray;
}
@end

@implementation WGHomeFloorClassifyGridItemCell

- (void)loadSubviews {
    NSMutableArray *itemViewArray = [[NSMutableArray alloc] init];
    for (int num = 0; num < 4; ++num) {
        WGHomeFloorClassifyGridView *itemView = [[WGHomeFloorClassifyGridView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8) + num * kAppAdaptWidth(83 + 8), kAppAdaptHeight(10), kAppAdaptWidth(83), kAppAdaptHeight(136))];
        itemView.tag = num;
        [itemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
        [self.contentView addSubview:itemView];
        [itemViewArray addObject:itemView];
    }
    _itemViewArray = itemViewArray;
}

- (void)showWithArray:(NSArray *)array {
    _dataArray = array;
    
    for (int num = 0; num < _itemViewArray.count; ++num) {
        WGHomeFloorClassifyGridView *itemView = _itemViewArray[num];
        if (num < _dataArray.count) {
            itemView.hidden = NO;
            [itemView showWithData:(JHObject *)_dataArray[num]];
        }
        else {
            itemView.hidden = YES;
        }
    }
}

- (void)handleClick:(UIGestureRecognizer *)recognizer {
    if (self.onApply) {
        NSInteger tag = recognizer.view.tag;
        self.onApply(_dataArray[tag]);
    }
}

@end
