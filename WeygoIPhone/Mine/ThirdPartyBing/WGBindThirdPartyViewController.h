//
//  WGBindThirdPartyViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGImageVerificationCodeResponse.h"

@interface WGBindThirdPartyViewController : WGViewController
{
    WGImageVerificationCodeResponse *_verificationCodeResponse;
}

- (void)refreshkVerificationCode;

@end
