//
//  WGClassifyKeywordView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHotSearchView.h"
#import "WGBorderButton.h"
#import "WGSearchKeywordItem.h"

@interface WGHotSearchView ()
{
    NSArray *_dataArray;
    NSMutableArray *_keywordMarksBtnMArray;
}
@end

@implementation WGHotSearchView

- (id)initWithFrame:(CGRect)frame disArray:(NSArray*)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = dataArray;
        _keywordMarksBtnMArray = [[NSMutableArray alloc] init];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    CGFloat leftSepX = kAppAdaptWidth(16);
    CGFloat rightSepX = kAppAdaptWidth(16);
    CGFloat topSepY = kAppAdaptHeight(16);
    CGFloat bottomSepY = kAppAdaptHeight(16);
    CGFloat lineSepX = kAppAdaptWidth(9);
    CGFloat columnSepY = kAppAdaptHeight(40);
    NSInteger curLineNum = 0;
    __weak id weakSelf = self;
    for (WGSearchKeywordItem *itemInfo in _dataArray) {
        WGBorderButton *itemBtn = [[WGBorderButton alloc] initWithFrame:CGRectMake(0, 0, 100, kAppAdaptHeight(32))];
        itemBtn.cornerRadius = kAppAdaptHeight(16);
        itemBtn.titleColor = WGAppTitleColor;
        itemBtn.backgroundColor = kHRGB(0xf8FAFA);
        itemBtn.font = kAppAdaptFont(14);
        itemBtn.distanceBetweenTitleAndBorder = kAppAdaptWidth(13);
        itemBtn.onTouch = ^(void) {
            [weakSelf handleTouch:itemInfo];
        };
        [itemBtn.btn setTitle:itemInfo.name forState:UIControlStateNormal];
        [itemBtn sizeToFit];
        itemBtn.tag = itemInfo.id;
        [self addSubview:itemBtn];
        
        //CGRect frame = CGRectZero;
        WGBorderButton *lastBtn = [_keywordMarksBtnMArray lastObject];
        if (lastBtn)
        {
            CGRect lastFrame = lastBtn.frame;
            if (lastFrame.origin.x + lastFrame.size.width + lineSepX +
                itemBtn.frame.size.width + rightSepX > self.frame.size.width)
            {
                curLineNum++;
                CGRect curFrame = CGRectMake(leftSepX, curLineNum * columnSepY + topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
                [itemBtn setFrame:curFrame];
            }
            else {
                CGRect curFrame = CGRectMake(lastFrame.origin.x + lastFrame.size.width + lineSepX, curLineNum * columnSepY + topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
                [itemBtn setFrame:curFrame];
            }
        }
        else {
            CGRect curFrame = CGRectMake(leftSepX, topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
            [itemBtn setFrame:curFrame];
        }
        [_keywordMarksBtnMArray addObject:itemBtn];
    }
    CGRect tmpFrame = CGRectMake(0, CGRectGetMinY(self.frame), self.frame.size.width, topSepY + bottomSepY + (curLineNum + 1) * columnSepY - kAppAdaptWidth(8));
    self.frame = tmpFrame;
}

+ (CGFloat)getViewHeightWithWidth:(CGFloat)width data:(NSArray *)dataArray {
    float height = 0.0f;
    CGFloat leftSepX = kAppAdaptWidth(16);
    CGFloat rightSepX = kAppAdaptWidth(16);
    CGFloat topSepY = kAppAdaptWidth(16);
    CGFloat bottomSepY = kAppAdaptWidth(16);
    CGFloat lineSepX = kAppAdaptWidth(9);
    CGFloat columnSepY = kAppAdaptHeight(40);
    NSInteger curLineNum = 0;
    NSMutableArray* allMArray = [[NSMutableArray alloc] init];
    for (WGSearchKeywordItem *itemInfo in dataArray) {
        WGBorderButton *itemBtn = [[WGBorderButton alloc] initWithFrame:CGRectMake(0, 0, 100, kAppAdaptHeight(32))];
        itemBtn.cornerRadius = kAppAdaptHeight(16);
        itemBtn.font = kAppAdaptFont(14);
        itemBtn.distanceBetweenTitleAndBorder = kAppAdaptWidth(13);
        [itemBtn.btn setTitle:itemInfo.name forState:UIControlStateNormal];
        [itemBtn sizeToFit];
        
        //[self addSubview:itemBtn];
        //CGRect frame = CGRectZero;
        WGBorderButton *lastBtn = [allMArray lastObject];
        if (lastBtn) {
            CGRect lastFrame = lastBtn.frame;
            if (lastFrame.origin.x + lastFrame.size.width + lineSepX +
                itemBtn.frame.size.width + rightSepX > width) {
                curLineNum++;
                CGRect curFrame = CGRectMake(leftSepX, curLineNum*columnSepY + topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
                [itemBtn setFrame:curFrame];
            }
            else {
                CGRect curFrame = CGRectMake(lastFrame.origin.x + lastFrame.size.width + lineSepX, curLineNum*columnSepY + topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
                [itemBtn setFrame:curFrame];
            }
        }
        else {
            CGRect curFrame = CGRectMake(leftSepX, topSepY, itemBtn.frame.size.width, itemBtn.frame.size.height);
            [itemBtn setFrame:curFrame];
        }
        [allMArray addObject:itemBtn];
    }
    height = topSepY + bottomSepY + (curLineNum + 1) * columnSepY - kAppAdaptWidth(8);
    return height;
}

- (void)handleTouch:(WGSearchKeywordItem *)item {
    if (self.onApply) {
        self.onApply(item);
    }
}

- (NSArray *)dataArray {
    return _dataArray;
}

@end
