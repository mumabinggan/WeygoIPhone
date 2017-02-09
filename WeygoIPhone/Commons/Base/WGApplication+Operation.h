//
//  WGApplication+Operation.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"

@interface WGApplication (Operation)

@property (nonatomic, strong, readonly) NSString *sessionId;

@property (nonatomic, strong, readonly) NSArray *postCodes;

@property (nonatomic, strong) NSString *currentPostCode;

@property (nonatomic, strong) WGUser *user;

- (BOOL)isLogined;

@end
