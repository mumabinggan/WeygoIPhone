//
//  WGSettlementResultResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSettlementResultResponse.h"

@implementation WGSettlementResultResponse

- (BOOL)emptyShopCart {
    return self.code == 4;
}

@end
