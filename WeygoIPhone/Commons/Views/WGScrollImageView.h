//
//  WGScrollImageView.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/11.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHView.h"

typedef NS_ENUM(NSInteger, WGScrollImageViewFromType) {
    WGScrollImageViewFromTypeDefault = 0,
    WGScrollImageViewFromTypeGoodDetail,
};

@interface WGScrollImageView : JHView

@property (nonatomic, copy) void (^onClick)(NSInteger index);

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray fromType:(WGScrollImageViewFromType)fromType;

- (void)setImageArray:(NSArray *)imageArray;

@end
