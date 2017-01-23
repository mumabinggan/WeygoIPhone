//
//  LFBorderLabel.h
//  Mars
//
//  Created by Chris on 17/3/15.
//  Copyright (c) 2015 Mars. All rights reserved.
//

#import "JHView.h"

@interface WGBorderButton : JHView

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat distanceBetweenTitleAndBorder;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong, readonly) JHButton *btn;

//@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroudColor;
//@property (nonatomic, readonly) BOOL isSelected;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) void (^onTouch)();

- (BOOL)isSelected;

@end
