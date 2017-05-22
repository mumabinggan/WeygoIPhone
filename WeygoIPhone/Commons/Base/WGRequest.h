//
//  WGRequest.h
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHRequest.h"

@interface WGRequest : JHRequest

//@property (nonatomic, strong) NSString *sign;
//
//@property (nonatomic, strong) NSString *___store;

@property (nonatomic, strong) NSString *app;

@property (nonatomic, strong) NSString *os;

- (NSString *)apiSuffix;

@end
