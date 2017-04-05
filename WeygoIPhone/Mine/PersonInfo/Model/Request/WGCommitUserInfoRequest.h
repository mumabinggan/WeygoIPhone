//
//  WGCommitUserInfoRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGCommitUserInfoRequest : WGGuestRequest

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, assign) int sex;  //1:男 2：女

@property (nonatomic, strong) NSString *birth; //1990-12-23

@property (nonatomic, strong) NSString *tax;

@end
