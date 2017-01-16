//
//  WGAddReceiptViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGReceipt.h"

@interface WGEditReceiptViewController : WGViewController

@property (nonatomic, copy) void (^onApply)();

@property (nonatomic, strong) WGReceipt *receipt;

@end
