//
//  WGScanJumpBody.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGScanJumpBody.h"
#import "WGScanJumpGood.h"
#import "WGScanJumpClassify.h"

@implementation WGScanJumpBody

- (WGScanJumpBussinessContent *)bodyContent {
    if (_bodyContent) {
        return _bodyContent;
    }
    if (_type == WGScanJumpTypeGood) {
        _bodyContent = [[WGScanJumpGood alloc] initWithJSON:_bussiness];
    }
    else if (_type == WGScanJumpTypeClassify) {
        _bodyContent = [[WGScanJumpClassify alloc] initWithJSON:_bussiness];
    }
    return _bodyContent;
}

@end
