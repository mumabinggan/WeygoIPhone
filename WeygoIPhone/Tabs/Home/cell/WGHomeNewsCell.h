//
//  WGHomeNewsCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@interface WGHomeNewsCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(NSInteger index);

@end
