//
//  WGUser.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGUser : WGObject

@property (nonatomic, assign) long long userId;

@property (nonatomic, strong) NSString *sectionKey;

@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *surname;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, assign) int sex;  //1 : 男; 2 : 女

@property (nonatomic, strong) NSString *birth;

@property (nonatomic, strong) NSString *tax;

@property (nonatomic, strong) NSString *cap;

- (BOOL)isMan;

@end
