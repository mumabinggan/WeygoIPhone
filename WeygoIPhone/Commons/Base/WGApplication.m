//
//  WGApplication.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "WGClassifyRequest.h"
#import "WGBaseServiceRequest.h"

@interface WGApplication ()

@end

@implementation WGApplication

static WGApplication* _sharedInstance = nil;

+ (WGApplication *)sharedApplication {
    @synchronized([WGApplication class]) {
        if(!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
        return _sharedInstance;
    }
    return nil;
}

@end
