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
        _ascensore = 0;
        _country = kStr(@"Address_Italia");
    }
    return self;
}

- (NSArray *)ascensores {
    return @[kStr(@"Address_NoLift"), kStr(@"Address_HaveLift")];
}

- (NSString *)currentAscensore {
    if (_ascensore == 0) {
        return [self ascensores][0];
    }
    else {
        return [self ascensores][1];
    }
}

@end
