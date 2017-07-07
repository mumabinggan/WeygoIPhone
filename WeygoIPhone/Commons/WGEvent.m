//
//  WGEvent.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/21.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEvent.h"

@implementation WGEvent
{
    KochavaTracker *_kochavaTracker;
}

static WGEvent *_sharedInstance = nil;

+ (WGEvent *)shareInstance {
    @synchronized([WGEvent class]) {
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
            [_sharedInstance initBuried];
        }
        return _sharedInstance;
    }
    return nil;
}

- (void)initBuried {
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    parametersDictionary[kKVAParamAppGUIDStringKey] = @"koweygo-ios-7ijs7qpt";
    _kochavaTracker = [[KochavaTracker alloc] initWithParametersDictionary:parametersDictionary delegate:self];
}

- (void)registerCompletion:(NSString *)userId from:(NSString *)from {
    if (_kochavaTracker) {
        KochavaEvent *event = [KochavaEvent eventWithEventTypeEnum:KochavaEventTypeEnumRegistrationComplete];
        if (event) {
            event.infoDictionary = @{@"user_id" : userId, @"referral_from" : from};
            [_kochavaTracker sendEvent:event];
        }
    }
}

- (void)checkOutStart:(NSString *)userId sum:(NSString *)sum {
    if (_kochavaTracker) {
        KochavaEvent *event = [KochavaEvent eventWithEventTypeEnum:KochavaEventTypeEnumCheckoutStart];
        if (event) {
            event.infoDictionary = @{@"user_id" : userId, @"items_in_basket" : sum};
            [_kochavaTracker sendEvent:event];
        }
    }
}

- (void)purchase:(NSString *)sum orderId:(NSString *)orderId {
    if (_kochavaTracker) {
        KochavaEvent *event = [KochavaEvent eventWithEventTypeEnum:KochavaEventTypeEnumCheckoutStart];
        if (event) {
            event.infoDictionary = @{@"Sum" : sum, @"Order Id" : orderId};
            [_kochavaTracker sendEvent:event];
        }
    }
}

- (void)tracker:(nonnull KochavaTracker *)tracker didRetrieveAttributionDictionary:(nonnull NSDictionary *)attributionDictionary {
    NSLog(@"---tracker-----");
}

- (void)test {
    KochavaEvent *event = [KochavaEvent eventWithEventTypeEnum:KochavaEventTypeEnumLevelComplete];
    if (event != nil)
    {
        event.userIdString = @"ABCDEF12345";
        event.levelString = @"1";
        event.scoreString = @"15500";
        event.descriptionString = @"some description";
        event.durationTimeIntervalNumber = @(65.0);
    }
    [_kochavaTracker sendEvent: event];
    
}

//+ (id)alloc {
//    @synchronized([WGEvent class]) {
//        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
//        _sharedInstance = [super alloc];
//        return _sharedInstance;
//    }
//    return nil;
//}


@end
