//
//  WGScanJumpBody.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGScanJumpBussinessContent.h"
#import "WGScanJumpGood.h"
#import "WGScanJumpClassify.h"

typedef NS_ENUM(NSInteger, WGScanJumpType) {
    WGScanJumpTypeNone,
    WGScanJumpTypeGood,
    WGScanJumpTypeClassify,
};

@interface WGScanJumpBody : WGObject

@property (nonatomic, assign) WGScanJumpType type;

@property (nonatomic, strong) NSString *bussiness;

@property (nonatomic, strong) WGScanJumpBussinessContent *bodyContent;

@end
