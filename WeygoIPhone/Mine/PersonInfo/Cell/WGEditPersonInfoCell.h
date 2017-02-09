//
//  WGEditPersonInfoCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@interface WGEditPersonInfoCell : JHTableViewCell

@property (nonatomic, strong) JHTextField *textField;

@property (nonatomic, copy) void (^onEndEdit)(JHTableViewCell *cell);

@end
