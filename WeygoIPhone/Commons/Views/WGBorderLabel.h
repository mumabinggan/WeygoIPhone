//
//  WGBorderLabel.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGBorderLabel : JHView

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat distanceBetweenTitleAndBorder;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong, readonly) JHLabel *label;

@end
