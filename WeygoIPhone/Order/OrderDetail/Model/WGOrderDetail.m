//
//  WGOrderDetail.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderDetail.h"
#import "WGOrderGoodItem.h"

@implementation WGOrderDetail

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"goods" isEqualToString:propertyName]) {
        return [WGOrderGoodItem class];
    }
    else if ([@"pay" isEqualToString:propertyName]) {
        return [NSString class];
    }
    return [super classForArray:propertyName];
}

@end

@implementation WGOrderStatus

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"statusArray" isEqualToString:propertyName]) {
        return [WGOrderStatusItem class];
    }
    return [super classForArray:propertyName];
}

+ (NSDictionary *)convertKeyMapper {
    return @{@"statusArray" : @"status"};
}

@end

@implementation WGOrderStatusItem

@end

@implementation WGOrderDeliver

@end

@implementation WGOrderFax

@end

@implementation WGOrderPay

@end
