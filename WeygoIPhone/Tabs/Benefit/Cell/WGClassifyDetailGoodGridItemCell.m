//
//  WGClassifyDetailGoodGridItemCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailGoodGridItemCell.h"

@implementation WGClassifyDetailGoodGridItemCell

- (void)loadSubviews {
    [super loadSubviews];
    _firstItemView.displaySpecification = YES;
    _secondItemView.displaySpecification = YES;
}

+ (CGFloat)heightWithArray:(NSArray *)data {
    return kAppAdaptHeight(340);
}

@end
