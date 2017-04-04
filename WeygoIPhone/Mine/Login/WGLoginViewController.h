//
//  WGLoginViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGImageVerificationCodeResponse.h"
#import "WGLoginRequest.h"

typedef NS_ENUM(NSInteger, WGLoginFrom) {
    WGLoginFromDefault,
    WGLoginFromShopCart,
};

@class WGLoginViewController;

typedef void (^WGLoginCancelBlock)(WGLoginViewController *viewController);
typedef void (^WGLoginSuccessBlock)(WGLoginViewController *viewController);

@interface WGLoginViewController : WGViewController
{
    WGImageVerificationCodeResponse *_verificationCodeResponse;
}

@property (nonatomic, assign) WGLoginFrom from;

@property (nonatomic, copy) WGLoginCancelBlock cancelBlock;
@property (nonatomic, copy) WGLoginSuccessBlock successBlock;

- (void)refreshkVerificationCode;

+ (void)pushInNavigationController:(UINavigationController *)navigationController
                         loginFrom:(WGLoginFrom)loginFrom
                            sucess:(WGLoginSuccessBlock)successBlock
                            cancel:(WGLoginCancelBlock)cancelBlock;

@end
