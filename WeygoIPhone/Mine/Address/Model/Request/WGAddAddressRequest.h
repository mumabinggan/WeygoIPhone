//
//  WGAddAddressRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGAddAddressRequest : WGGuestRequest

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *firstname;

@property (nonatomic, strong) NSString *lastname;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *street;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *countryId;

@property (nonatomic, strong) NSString *cap;

@property (nonatomic, strong) NSString *telephone;

@property (nonatomic, assign) int hasLift;    //是否是电梯(1：是； 0：不是)

@property (nonatomic, strong) NSString *floor;

@property (nonatomic, strong) NSString *doorbell;

@property (nonatomic, strong) NSString *floorHole;

@end
