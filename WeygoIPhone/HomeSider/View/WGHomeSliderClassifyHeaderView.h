//
//  WGHomeSliderClassifyHeaderView.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewHeaderFooterView.h"

@interface WGHomeSliderClassifyHeaderView : JHTableViewHeaderFooterView

@property (nonatomic, strong) JHImageView *imageView;

@property (nonatomic, copy) void (^onApply)();

@end
