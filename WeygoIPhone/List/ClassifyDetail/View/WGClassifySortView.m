//
//  WGClassifySortView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifySortView.h"

@interface WGClassifySortView ()
{
    NSArray *_itemViewArray;
    NSArray *_itemTitleArray;
    NSArray *_itemImageArray;
    NSArray *_itemHighLightImageArray;
}
@end

@implementation WGClassifySortView

- (void)loadSubviews {
    [super loadSubviews];
    _itemImageArray = @[@"classify_detail_default", @"classify_detail_filter", @"classify_detail_vista"];
    _itemHighLightImageArray = @[@"classify_detail_default", @"classify_detail_filter", @"classify_detail_vista"];
    _itemTitleArray = @[kStr(@"Default Sort"), kStr(@"Filtro"), kStr(@"Vista")];
    NSInteger count = _itemImageArray.count;
    NSMutableArray *itemMArray = [NSMutableArray array];
    CGFloat width = kDeviceWidth / count;
    for (int num = 0; num < count; ++num) {
        JHButton *itemBtn = [[JHButton alloc] initWithFrame:CGRectMake(width * num, 0, self.width / count, self.height)];
        [itemBtn addTarget:self action:@selector(touchItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [itemBtn setImage:[UIImage imageNamed:_itemImageArray[num]] forState:UIControlStateNormal];
        itemBtn.tag = num;
        itemBtn.titleLabel.font = kAppAdaptFont(14);
        [itemBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
        [itemBtn setTitle:[NSString stringWithFormat:@" %@", _itemTitleArray[num]] forState:UIControlStateNormal];
        [self addSubview:itemBtn];
        [itemMArray addObject:itemBtn];
    }
    _itemViewArray = itemMArray;
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, self.height - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self addSubview:lineView];
}

- (void)touchItemBtn:(JHButton *)sender {
    if (self.onApply) {
        self.onApply(sender.tag);
    }
}

- (void)setItemSelected:(BOOL)selected index:(NSInteger)index {
    [self setItemSelected:selected title:nil index:index];
}

- (void)setItemSelected:(BOOL)selected title:(NSString *)title index:(NSInteger)index {
    JHButton *itemBtn = _itemViewArray[index];
    if (selected) {
        [itemBtn setImage:[UIImage imageNamed:_itemHighLightImageArray[index]] forState:UIControlStateNormal];
        [itemBtn setTitleColor:WGAppBlueButtonColor forState:UIControlStateNormal];
    }
    else {
        [itemBtn setImage:[UIImage imageNamed:_itemImageArray[index]] forState:UIControlStateNormal];
        [itemBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    }
    if (![NSString isNullOrEmpty:title]) {
        [itemBtn setTitle:title forState:UIControlStateNormal];
    }
}

@end
