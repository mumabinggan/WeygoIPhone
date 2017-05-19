//
//  WGBindThirdPartyViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGImageVerificationCodeResponse.h"
#import "PooCodeView.h"
#import "WGVerificationCodeView.h"

@interface WGBindThirdPartyViewController : WGViewController
{
    WGImageVerificationCodeResponse *_verificationCodeResponse;
    
    JHView *_registerView;
    JHTextField *_usernameTextField;
    JHTextField *_passwordTextField;
    JHTextField *_codeTextField;
    PooCodeView *_verificationCodeBtn;
    
    JHView *_unRegisterView;
    JHTextField *_mobileTextField;
    JHTextField *_unRegisterCodeTextField;
    JHTextField *_surnameTextField;
    JHTextField *_nameTextField;
    JHTextField *_emailTextField;
    JHTextField *_unRegisterPasswordTextField;
    JHTextField *_confirmPasswordTextField;
    
    WGVerificationCodeView *_unRegisterVerificationCodeBtn;
}

@property (nonatomic, strong) NSString *uniqueId;

@property (nonatomic, assign) WGThirdPartyLoginType type;

@end
