//
//  TWNoDataView.h
//  LiFang
//
//  Created by Hugo Wang on 15/11/5.
//  Copyright © 2015年 Lifang. All rights reserved.
//

typedef NS_ENUM(NSUInteger, TWDefaultBackgroundViewType) {
    TWDefaultBackgroundViewNoData = 1,
    TWDefaultBackgroundViewRequestError,
};

#import "JHView.h"

@interface TWDefaultBackgroundView : JHView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *btnTitle;

@property (nonatomic, copy) UIColor *btnTitleColor;

@property (nonatomic, copy) UIColor *btnBackgroundColor;

@property (nonatomic, copy) void (^onApply)();

@property (nonatomic, assign) TWDefaultBackgroundViewType defaultViewType;

@property (nonatomic, assign) CGFloat verticalOffset;

@property (nonatomic, assign) CGFloat viewHeight;


+ (TWDefaultBackgroundView *)defaultBackgroundViewWithType:(TWDefaultBackgroundViewType)tpye image:(UIImage *)image title:(NSString *)title subTitle:(NSString *)subTitle btnTitle:(NSString *)btnTitle completion:(void(^)())completion;

@end
