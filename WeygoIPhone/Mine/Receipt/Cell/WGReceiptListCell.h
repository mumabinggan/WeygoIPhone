//
//  WGReceiptListCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@class WGReceipt;

@interface WGReceiptListCell : JHTableViewCell

@property (nonatomic, copy) void (^onDefault)(WGReceipt *receipt);

@property (nonatomic, copy) void (^onUse)(WGReceipt *receipt);

@property (nonatomic, copy) void (^onModify)(WGReceipt *receipt);

@end
