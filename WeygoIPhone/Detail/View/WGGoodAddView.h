//
//  WGGoodAddView.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

typedef NS_ENUM(NSInteger, WGGoodAddViewFromType) {
    WGGoodAddViewFromGoodDetail,
    WGGoodAddViewFromCart,
};

@interface WGGoodAddView : JHView

@property (nonatomic, assign) WGGoodAddViewFromType fromType;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) void (^onAdd)(NSInteger count);

@property (nonatomic, copy) void (^onSub)(NSInteger count);

@end
