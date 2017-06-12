//
//  WGClassifyKeywordView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyKeywordView.h"
#import "WGBorderButton.h"
#import "WGClassifyKeyword.h"
#import "WGClassifyItem.h"

@interface WGClassifyKeywordView ()
{
    NSArray *_dataArray;
    NSMutableArray *_keywordMarksBtnMArray;
}
@end

@implementation WGClassifyKeywordView

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
    if (_dataArray == nil || _dataArray.count == 0) {
        self.frame = CGRectMake(self.x, self.y, self.width, 0.1);
    }
    //[super loadSubviews];
    //self.backgroundColor = kClearColor;
    CGFloat leftSepX = kAppAdaptWidth(16);
    CGFloat rightSepX = kAppAdaptWidth(16);
    CGFloat topSepY = kAppAdaptHeight(16);
    CGFloat bottomSepY = kAppAdaptHeight(16);
    CGFloat lineSepX = kAppAdaptWidth(9);
    CGFloat columnSepY = kAppAdaptHeight(40);
    NSInteger curLineNum = 0;
    __weak id weakSelf = self;
    for (WGObject *itemInfo in _dataArray) {
        WGBorderButton *itemBtn = [[WGBorderButton alloc] initWithFrame:CGRectMake(0, 0, 100, kAppAdaptHeight(32))];
        itemBtn.cornerRadius = kAppAdaptHeight(16);
        itemBtn.titleColor = WGAppTitleColor;
        itemBtn.selectedTitleColor = kWhiteColor;
        itemBtn.backgroundColor = kHRGB(0xf8FAFA);
        itemBtn.selectedBackgroudColor = WGAppBaseColor;
        itemBtn.font = kAppAdaptFont(14);
        itemBtn.distanceBetweenTitleAndBorder = kAppAdaptWidth(13);
        itemBtn.onTouch = ^(void) {
            [weakSelf handleTouch:itemInfo];
        };
        NSString *name = nil;
        BOOL isSelected = YES;
        long id = 0;
        if ([itemInfo isKindOfClass:[WGClassifyKeyword class]]) {
            name = ((WGClassifyKeyword *)itemInfo).name;
            isSelected = ((WGClassifyKeyword *)itemInfo).isSelected;
            id = ((WGClassifyKeyword *)itemInfo).id;
        }
        else {
            name = ((WGClassifyItem *)itemInfo).name;
            isSelected = ((WGClassifyItem *)itemInfo).isSelected;
            id = ((WGClassifyItem *)itemInfo).id;
        }
        [itemBtn.btn setTitle:name forState:UIControlStateNormal];
        [itemBtn sizeToFit];
        itemBtn.tag = id;
        [itemBtn setSelected:isSelected];
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

- (void)handleTouch:(WGObject *)keyword {
    if ([keyword isKindOfClass:[WGClassifyKeyword class]]) {
        ((WGClassifyKeyword *)keyword).isSelected = !((WGClassifyKeyword *)keyword).isSelected;
    }
    else if ([keyword isKindOfClass:[WGClassifyItem class]]) {
        ((WGClassifyItem *)keyword).isSelected = !((WGClassifyItem *)keyword).isSelected;
    }
    
}

- (NSArray *)dataArray {
    return _dataArray;
}

@end
