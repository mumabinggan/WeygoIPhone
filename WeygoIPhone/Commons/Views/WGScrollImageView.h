//
//  WGScrollImageView.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/11.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGScrollImageView : JHView

@property (nonatomic, copy) void (^onClick)(NSInteger index);

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

- (void)setImageArray:(NSArray *)imageArray;

@end
