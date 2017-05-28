//
//  WGSegmentView.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WGSegmentViewType) {
    WGSegmentViewTypeWidthImmutabile,
    WGSegmentViewTypeWidthMutabile,
};

@interface WGSegmentView : UIView

@property (nonatomic, assign) WGSegmentViewType type;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) BOOL bounces;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, copy) void (^onSelect)(NSInteger oldIndex, NSInteger newIndex);

- (void)setTitleArray:(NSArray *)titleArray;

- (void)setSelectedIndex:(NSInteger)selectedIndex;

- (void)setTitle:(NSString *)title index:(NSInteger)index;

@end
