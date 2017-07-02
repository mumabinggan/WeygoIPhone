//
//  WGCommitOrderResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderResponse.h"

@implementation WGCommitOrderResponse

- (BOOL)overWeight {
    return self.code == 3;
}

@end

@implementation WGCommitOrderData

@end
