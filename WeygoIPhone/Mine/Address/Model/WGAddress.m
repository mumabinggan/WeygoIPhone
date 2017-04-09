//
//  WGAddress.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddress.h"

@implementation WGAddress

- (id)init {
    self = [super init];
    if (self) {
        _ascensore = 1;
        _country = kStr(@"Address_Italia");
    }
    return self;
}

- (NSArray *)ascensores {
    return @[kStr(@"Address_HaveLift"), kStr(@"Address_NoLift")];
}

- (NSString *)currentAscensore {
    if (_ascensore == 0) {
        return [self ascensores][1];
    }
    else {
        return [self ascensores][0];
    }
}

@end
