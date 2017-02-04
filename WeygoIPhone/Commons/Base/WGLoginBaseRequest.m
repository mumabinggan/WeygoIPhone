//
//  WGLoginRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginBaseRequest.h"

@implementation WGLoginBaseRequest

- (NSString *)funcName {
    return @"login";
}

- (NSArray *)parameterKeyArray {
    return @[@"username", @"apiKey"];
}

- (NSArray *)parameterTypeArray {
    return @[@"string", @"string"];
}

- (NSArray *)parameterValueArray {
    return @[@"weygo", @"weygo1988"];
}

@end
