//
//  WGGoodDesCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@interface WGGoodDesCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(NSInteger index);

@property (nonatomic, assign) NSInteger index;

@end
