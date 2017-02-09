//
//  WGBaseServiceRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseServiceRequest.h"

@implementation WGBaseServiceRequest

- (NSString *)pathName {
    return @"base";
}

- (NSArray *)parameterValueArray {
    return @[@"f1db8542447477960c3336b0fe4bb78f", self.pathName, [NSNull null]];
}

@end
