//
//  WGGoodAddView.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodAddView.h"

@interface WGGoodAddView ()
{
    JHLabel *_countLabel;
}
@end

@implementation WGGoodAddView

- (void)loadSubviews {
    _count = 0;
    UIButton *subBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.height, self.height)];
    [subBtn addTarget:self action:@selector(touchSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    [subBtn setImage:[UIImage imageNamed:@"sub-good"] forState:UIControlStateNormal];
    [self addSubview:subBtn];
    
    _countLabel = [[JHLabel alloc] initWithFrame:CGRectMake(subBtn.maxX, 0, self.width - 2 * subBtn.width, self.height)];
    _countLabel.font = kAppAdaptFont(14);
    _countLabel.text = @(_count).stringValue;
    _countLabel.textColor = WGAppBaseColor;
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - self.height, 0, self.height, self.height)];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"add-good"] forState:UIControlStateNormal];
    [self addSubview:addBtn];
}

- (void)touchAddBtn:(JHButton *)sender {
    if (_fromType == WGGoodAddViewFromGoodDetail) {
        _countLabel.text = @(++_count).stringValue;
    }
    if (self.onAdd) {
        self.onAdd(_count);
    }
}

- (void)touchSubBtn:(JHButton *)sender {
    if (_count != 0) {
        _count--;
    }
    _countLabel.text = @(_count).stringValue;
    if (self.onSub) {
        self.onSub(_count);
    }
}

- (void)setCount:(NSInteger)count {
    _count = count;
    _countLabel.text = @(_count).stringValue;
}

@end
