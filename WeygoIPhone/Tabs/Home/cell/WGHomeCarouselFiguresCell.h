//
//  WGHomeCarouselFiguresCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@interface WGHomeCarouselFiguresCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(NSInteger index);

- (void)showWithArray:(NSArray *)array;

@end
