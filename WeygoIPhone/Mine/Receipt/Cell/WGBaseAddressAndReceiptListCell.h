//
//  WGBaseListCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGObject.h"

@interface WGBaseAddressAndReceiptListCell : JHTableViewCell
{
    JHLabel *_title1NameLabel;
    JHLabel *_title2NameLabel;
    JHLabel *_title3NameLabel;

    JHLabel *_title1ValueLabel;
    JHLabel *_title2ValueLabel;
    JHLabel *_title3ValueLabel;
    
    JHButton *_defaultBtn;
    JHButton *_useBtn;
    JHButton *_modifyBtn;
    JHView *_lineView;
}

@property (nonatomic, assign) BOOL hasUse;

@property (nonatomic, copy) void (^onDefault)(WGObject *receipt);

@property (nonatomic, copy) void (^onUse)(WGObject *receipt);

@property (nonatomic, copy) void (^onModify)(WGObject *receipt);

@end
