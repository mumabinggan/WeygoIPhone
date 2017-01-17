//
//  WGBaseEditCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@interface WGBaseAddressAndReceiveEditCell : JHTableViewCell

@property (nonatomic, strong) JHTextField *textField;

@property (nonatomic, copy) void (^onEndEdit)(JHTableViewCell *cell);

@end
