//
//  WGScrollAdView.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGScrollAdView : JHView

@property (nonatomic, copy) void (^onTouch)(NSInteger index);

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end
