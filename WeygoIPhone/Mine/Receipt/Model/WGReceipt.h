//
//  WGReceipt.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGReceipt : WGObject

@property (nonatomic, assign) long long receiptId;

@property (nonatomic, strong) NSString *companyName;

@property (nonatomic, strong) NSString *italia;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *civico; //街道号

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *cap;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *taxCode;

//是默认发票
@property (nonatomic, assign) BOOL isDefault;

@end
