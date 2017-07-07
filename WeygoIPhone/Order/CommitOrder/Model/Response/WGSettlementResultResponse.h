//
//  WGSettlementResultResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGSettlementResult.h"

@interface WGSettlementResultResponse : WGResponse

@property (nonatomic, strong) WGSettlementResult *data;

- (BOOL)emptyShopCart;

@end
