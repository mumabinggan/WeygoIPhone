//
//  WGIntegrationHelpView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"

@interface WGIntegrationHelpView : JHPopoverView

@property (nonatomic, copy) void (^onApply)(NSInteger index);

@property (nonatomic, strong) NSString *tip;

@end
