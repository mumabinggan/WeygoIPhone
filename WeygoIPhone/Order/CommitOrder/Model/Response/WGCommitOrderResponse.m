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

- (BOOL)belowMinPrice {
    return self.code == 4;
}

- (BOOL)hasExpireGood {
    return self.code == 5;
}

@end

@implementation WGCommitOrderData

@end
