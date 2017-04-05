//
//  WGVerificationCodeView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGVerificationCodeView : JHView

@property (nonatomic, copy) void (^onApply)();

@end
