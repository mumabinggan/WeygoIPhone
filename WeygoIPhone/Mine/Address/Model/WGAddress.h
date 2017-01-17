//
//  WGAddress.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGAddress : WGObject

@property (nonatomic, assign) long long addressId;

@property (nonatomic, strong) NSString *companyName;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *country;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *cap;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *streetNumber;

@property (nonatomic, strong) NSString *citofono;

@property (nonatomic, strong) NSString *scala;

@property (nonatomic, strong) NSString *ascensore;

@property (nonatomic, strong) NSString *piano;

//是否默认
@property (nonatomic, assign) BOOL isDefault;

@end
