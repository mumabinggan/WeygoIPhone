//
//  WGScanCodeView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGScanCodeView : UIView

@property (nonatomic, strong) void (^onSuccess)(NSString *scanResultJsonString);

@end
