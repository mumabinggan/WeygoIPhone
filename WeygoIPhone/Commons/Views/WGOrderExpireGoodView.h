//
//  WGOrderExpireGoodView.h
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"
#import "WGOrderExpireGood.h"

@interface WGOrderExpireGoodView : JHPopoverView

@property (nonatomic, strong) void (^onChangeTime)();

@property (nonatomic, strong) void (^onDeleteExpireGood)();

- (id)initWithFrame:(CGRect)frame expireGood:(WGOrderExpireGood *)expireGood;

@end
