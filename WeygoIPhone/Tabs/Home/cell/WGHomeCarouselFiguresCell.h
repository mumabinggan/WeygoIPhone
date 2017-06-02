//
//  WGHomeCarouselFiguresCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGScrollImageView.h"

@interface WGHomeCarouselFiguresCell : JHTableViewCell
{
    WGScrollImageView *_scrollImageView;
}

@property (nonatomic, copy) void (^onApply)(NSInteger index);

- (void)showWithArray:(NSArray *)array;

+ (CGFloat)heightWithData:(NSArray *)array;

@end
