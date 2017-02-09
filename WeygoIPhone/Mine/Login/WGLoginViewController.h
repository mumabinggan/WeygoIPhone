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

@interface WGLoginViewController : WGViewController
{
    WGImageVerificationCodeResponse *_verificationCodeResponse;
}

- (void)refreshkVerificationCode;

@end
