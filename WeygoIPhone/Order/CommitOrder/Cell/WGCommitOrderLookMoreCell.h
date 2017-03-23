//
//  WGCommitOrderLookMoreCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGSettlementResult.h"

@interface WGCommitOrderLookMoreCell : JHTableViewCell

@property (nonatomic, copy) void (^onMore)(WGSettlementTips *tip);

@end
