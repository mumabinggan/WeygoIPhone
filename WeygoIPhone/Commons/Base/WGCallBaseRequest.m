//
//  WGCallRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCallBaseRequest.h"

@implementation WGCallBaseRequest

- (NSString *)funcName {
    return @"call";
}

- (NSArray *)parameterKeyArray {
    return @[@"sessionId", @"resourcePath", @"args"];
}

- (NSArray *)parameterTypeArray {
    return @[@"string", @"string", @"anyType"];
}

@end
