//
//  WGPostCodePopoverView.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"

@interface WGPostCodePopoverView : JHPopoverView

@property (nonatomic, copy) void (^onApply)(NSString *postCode);

@end
