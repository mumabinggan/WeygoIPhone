//
//  WGApplication+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "WGSessionRequest.h"
#import "WGSessionResponse.h"
#import "WGBaseServiceRequest.h"
#import "WGBaseServiceResponse.h"
#import "WGImageVerificationCodeResponse.h"
#import "WGAddGoodToCartRequest.h"
#import "WGAddGoodToCartResponse.h"
#import "WGUserInfoResponse.h"
#import "WGGetVerifyCodeRequest.h"
#import "WGGetVerifyCodeResponse.h"

@interface WGApplication (Request)

- (void)loadBaseServiceOnCompletion:(void (^)(WGBaseServiceResponse *))completion;

- (void)loadSliderResponseOnCompletion:(void (^)(WGHomeSliderResponse *))completion;

- (void)loadImageVerificationCodeOnCompletion:(void (^)(WGImageVerificationCodeResponse *))completion;

- (void)loadAddGoodToCart:(long long)goodId
                    count:(NSInteger)count
             onCompletion:(void (^)(WGAddGoodToCartResponse *))completion;

- (void)loadUserInfoOnCompletion:(void (^)(WGUserInfoResponse *))completion;

- (void)loadVerificationCodeUserName:(NSString *)username
                         countryCode:(NSString *)countryCode
                        onCompletion:(void (^)(WGGetVerifyCodeResponse *))completion;

@end
