//
//  WGClassifySortView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGClassifySortView : JHView

@property (nonatomic, copy) void (^onApply)(NSInteger index);

- (void)setItemSelected:(BOOL)selected index:(NSInteger)index;

- (void)setItemSelected:(BOOL)selected title:(NSString *)title index:(NSInteger)index;

@end
