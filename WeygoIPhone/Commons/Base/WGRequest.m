//
//  WGRequest.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@implementation WGRequest

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)url {
    return [NSString stringWithFormat:@"%@://%@/%@/%@%@", [self scheme], [self host], [self userPath], [self api], [self apiSuffix]];
}

- (NSString *)host {
    return @"weygo3.cloudhy.com";
}

- (NSString *)userPath {
    return @"appservice";
}

- (NSString *)apiSuffix {
    NSMutableString *returnString = [[NSMutableString alloc] init];
    NSDictionary *dictionary = self.dictionary;
    [returnString appendString:WGAppIdKey];
    [returnString appendString:WGAppIdValue];
    [returnString appendString:WGAppkeyKey];
    [returnString appendString:[WGAppkeyValue md5]];
    NSComparator cmptr = ^(NSString *obj1, NSString *obj2){
        return [obj1 compare:obj2];
    };
    NSArray *array = [dictionary.allKeys sortedArrayUsingComparator:cmptr];
    for (NSString *key in array) {
        [returnString appendString:key];
        if ([dictionary[key] isKindOfClass:[NSNumber class]]) {
            [returnString appendString:((NSNumber *)(dictionary[key])).stringValue];
        }
        else if ([dictionary[key] isKindOfClass:[NSString class]]) {
            [returnString appendString:dictionary[key]];
        }
    }
    return [NSString stringWithFormat:@"sign=%@&___store=%@", [returnString md5], @"mobileitaly"];;
}

@end
