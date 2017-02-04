//
//  WGApplication.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHObject.h"
#import "WGSessionRequest.h"
#import "WGSessionResponse.h"

@interface WGApplication : JHObject

@property (nonatomic, strong) WGSessionResponse *sessionResponse;

+ (WGApplication *)sharedApplication;

- (void)loadSessionOnCompletion:(void (^)(WGSessionResponse *))completion;

- (void)loadClassifyOnCompletion:(void (^)(WGSessionResponse *))completion;

@end
