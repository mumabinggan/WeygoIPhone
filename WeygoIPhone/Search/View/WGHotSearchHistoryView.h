//
//  WGClassifyKeywordView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"
#import "WGSearchKeywordItem.h"

@interface WGHotSearchHistoryView : JHView

@property (nonatomic, strong) void (^onLongApply)(WGSearchKeywordItem *item);

@property (nonatomic, strong) void (^onApply)(WGSearchKeywordItem *item);

- (id)initWithFrame:(CGRect)frame disArray:(NSArray*)dataArray;

+ (CGFloat)getViewHeightWithWidth:(CGFloat)width data:(NSArray *)dataArray;

- (NSArray *)dataArray;

@end
