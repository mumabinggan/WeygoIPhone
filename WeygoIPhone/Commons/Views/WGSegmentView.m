//
//  WGSegmentView.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGSegmentView.h"

@interface WGSegmentView ()
{
    JHScrollView *_contentScrollView;
    
    NSMutableArray *_titleBtnArray;
    JHView *_lineView;
    
    NSInteger _selectedIndex;
}
@end

@implementation WGSegmentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView:frame];
    }
    return self;
}

- (void)initSubView:(CGRect)frame {
    
    _titleColor = kBlackColor;
    _titleSelectedColor = kBlueColor;
    _lineColor = kGreenColor;
    _bounces = YES;
    _selectedIndex = 0;
    
    JHView *view = [[JHView alloc] initWithFrame:self.bounds];
    [self addSubview:view];
    
    _contentScrollView = [[JHScrollView alloc] initWithFrame:self.bounds];
    //_contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _contentScrollView.bounces = _bounces;
    [self addSubview:_contentScrollView];
    //[_contentScrollView setBackgroundColor:kGreenColor];
    _titleBtnArray = [[NSMutableArray alloc] init];
    _lineView = [[JHView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = _lineColor;
}

- (void)drawView {
    
    _selectedIndex = 0;
    
    //clean scrollview content
    for (UIView *view in _contentScrollView.subviews) {
        if ([view isKindOfClass:[JHButton class]]) {
            [view removeFromSuperview];
        }
    }
    //add scrollview content
    int itemX = 0;
    CGRect frame = CGRectZero;
    for (JHView *item in _titleBtnArray) {
        frame = item.frame;
        frame.origin = CGPointMake(itemX, 0);
        item.frame = frame;
        itemX += item.width;
        [_contentScrollView addSubview:item];
    }
    //set line
    float width = self.width / _titleBtnArray.count;
    float height = kAppAdaptHeight(4);
    _lineView.frame = CGRectMake(_selectedIndex * width, self.height - height, width, height);
    [_contentScrollView addSubview:_lineView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_titleBtnArray.count > selectedIndex) {
        [self touchItemBtn:_titleBtnArray[selectedIndex]];
    }
}

- (void)setTitleArray:(NSArray *)titleArray {
    [_titleBtnArray removeAllObjects];
    float itemWidth = self.width / titleArray.count;
    for (int num = 0; num < titleArray.count; ++num) {
        NSString *title = titleArray[num];
        JHButton *titleBtn = [JHButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(0, 0, itemWidth, self.height);
        [titleBtn setTitle:title forState:UIControlStateNormal];
        [titleBtn setTitleColor:(_selectedIndex == num) ? _titleSelectedColor : _titleColor forState:UIControlStateNormal];
        titleBtn.tag = num;
        [titleBtn addTarget:self action:@selector(touchItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtnArray addObject:titleBtn];
    }
    [self drawView];
}

- (void)touchItemBtn:(JHButton *)sender {
    UIColor *titleColor = nil;
    for (JHButton *item in _titleBtnArray) {
        titleColor = [item isEqual:sender] ? _titleSelectedColor : _titleColor;
        [item setTitleColor:titleColor forState:UIControlStateNormal];
    }
    //set _selectedIndex
    NSInteger preSelectedIndex = _selectedIndex;
    _selectedIndex = sender.tag;
    if (self.onSelect) {
        self.onSelect(preSelectedIndex, _selectedIndex);
    }
    [UIView animateWithDuration:0.25 animations:^(void) {
        CGRect frame = _lineView.frame;
        frame.origin.x = sender.x;
        _lineView.frame = frame;
    }];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    for (int num = 0; num < _titleBtnArray.count; ++num) {
        if (_selectedIndex != num) {
            JHButton *item = _titleBtnArray[num];
            [item setTitleColor:_titleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    for (int num = 0; num < _titleBtnArray.count; ++num) {
        if (_selectedIndex == num) {
            JHButton *item = _titleBtnArray[num];
            [item setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
            return;
        }
    }
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    _contentScrollView.bounces = _bounces;
}

@end
