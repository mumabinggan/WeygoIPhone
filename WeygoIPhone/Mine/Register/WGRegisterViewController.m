//
//  WGRegisterViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRegisterViewController.h"
#import "WGRegisterViewController+Request.h"
#import "WGVerificationCodeView.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "WGBindThirdPartyViewController.h"

@interface WGRegisterViewController ()
{
    JHScrollView *_scrollView;
    
    WGVerificationCodeView *_verificationCodeBtn;
}
@end

@implementation WGRegisterViewController

- (BOOL)prefersNavigationBarHidden {
    return YES;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    _scrollView = [[JHScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(30), kDeviceWidth, kAppAdaptHeight(24))];
    titleLabel.text = kStr(@"Register_Title");
    titleLabel.font = kAppAdaptFont(16);
    titleLabel.textColor = kWhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    JHButton *returnBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(37), kAppAdaptWidth(20), kAppAdaptHeight(11))];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"app_return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(touchReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    JHButton *returnBackgroundBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(0), kAppAdaptHeight(0), kAppAdaptWidth(80), kAppAdaptHeight(80))];
    [returnBackgroundBtn addTarget:self action:@selector(touchReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBackgroundBtn];
    
    JHView *loginBgView = [[JHView alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(86), kAppAdaptHeight(30), kAppAdaptWidth(70), kAppAdaptHeight(24))];
    [loginBgView addSingleTapGestureRecognizerWithTarget:self action:@selector(intoLoginViewController:)];
    [self.view addSubview:loginBgView];
    JHLabel *loginLabel = [[JHLabel alloc] initWithFrame:loginBgView.bounds];
    loginLabel.text = kStr(@"Register_Login");
    loginLabel.font = kAppAdaptFont(16);
    loginLabel.textColor = kWhiteColor;
    loginLabel.textAlignment = NSTextAlignmentRight;
    [loginBgView addSubview:loginLabel];
    
    JHImageView *headerImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, -20, kDeviceWidth, kAppAdaptHeight(230))];
    headerImageView.image = [UIImage imageNamed:@"register_headImage"];
    [_scrollView addSubview:headerImageView];
    
    float radius = kAppAdaptWidth(20);
    JHButton *wechatBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), headerImageView.maxY + kAppAdaptHeight(15), kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    [wechatBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Login_WeChat")] forState:UIControlStateNormal];
    [wechatBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = kAppAdaptFont(14);
    [wechatBtn setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(touchWeChatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:wechatBtn];
    
    JHButton *facebookBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2 + kAppAdaptWidth(8), wechatBtn.y, kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    [facebookBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Login_FaceBook")] forState:UIControlStateNormal];
    [facebookBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    facebookBtn.titleLabel.font = kAppAdaptFont(14);
    [facebookBtn setImage:[UIImage imageNamed:@"login_facebook"] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(touchFaceBookBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:facebookBtn];
    
    JHImageView *countryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), facebookBtn.maxY + kAppAdaptHeight(33), kAppAdaptWidth(18), kAppAdaptHeight(12))];
    countryImageView.image = [UIImage imageNamed:@"Italiana_image"];
    [_scrollView addSubview:countryImageView];
    
    JHLabel *areaCodeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(64), facebookBtn.maxY + kAppAdaptHeight(27), kAppAdaptWidth(60), kAppAdaptHeight(24))];
    areaCodeLabel.text = @"+39";
    areaCodeLabel.textColor = WGAppLightNameLabelColor;
    areaCodeLabel.textAlignment = NSTextAlignmentCenter;
    areaCodeLabel.font = kAppAdaptFont(14);
    areaCodeLabel.layer.masksToBounds = YES;
    areaCodeLabel.layer.cornerRadius = kAppAdaptHeight(12);
    areaCodeLabel.backgroundColor = kHRGB(0xF8FAFA);
    areaCodeLabel.layer.borderColor = kHRGB(0xEBEFF0).CGColor;
    areaCodeLabel.layer.borderWidth = kAppAdaptWidth(1);
    [_scrollView addSubview:areaCodeLabel];
    
    float textFieldHeight = kAppAdaptHeight(48);
    float textFieldWidth = kDeviceWidth - kAppAdaptWidth(64);
    float textFieldX = kAppAdaptWidth(32);
    _mobileTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32 + 105), facebookBtn.maxY + kAppAdaptHeight(15), kDeviceWidth - kAppAdaptWidth(64 + 105), textFieldHeight)];
    _mobileTextField.font = kAppAdaptFont(14);
    _mobileTextField.placeholder = kStr(@"Register_Mobile");
    _mobileTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_mobileTextField];
    
    float lineY = _mobileTextField.height - kAppSepratorLineHeight;
    JHView *mobileLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, kDeviceWidth - kAppAdaptWidth(64), kAppSepratorLineHeight)];
    mobileLineView.backgroundColor = WGAppSeparateLineColor;
    [_mobileTextField addSubview:mobileLineView];
    
    _codeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _mobileTextField.maxY, textFieldWidth, textFieldHeight)];
    _codeTextField.font = kAppAdaptFont(14);
    _codeTextField.placeholder = kStr(@"Register_Code");
    _codeTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_codeTextField];
    
    WeakSelf;
    radius = kAppAdaptHeight(12);
    _verificationCodeBtn = [[WGVerificationCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(191), kAppAdaptHeight(12), kAppAdaptWidth(120), kAppAdaptHeight(24))];
    _verificationCodeBtn.onApply = ^(void) {
        [weakSelf touchVerificationCodeBtn:nil];
    };
    [_codeTextField addSubview:_verificationCodeBtn];
    
    JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    codeLineView.backgroundColor = WGAppSeparateLineColor;
    [_codeTextField addSubview:codeLineView];
    
    _surnameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _codeTextField.maxY, textFieldWidth, textFieldHeight)];
    _surnameTextField.font = kAppAdaptFont(14);
    _surnameTextField.placeholder = kStr(@"Register_Cognome");
    _surnameTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_surnameTextField];
    
    JHView *surnameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    surnameLineView.backgroundColor = WGAppSeparateLineColor;
    [_surnameTextField addSubview:surnameLineView];
    
    _nameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _surnameTextField.maxY, textFieldWidth, textFieldHeight)];
    _nameTextField.font = kAppAdaptFont(14);
    _nameTextField.placeholder = kStr(@"Register_Name");
    _nameTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_nameTextField];
    
    JHView *nameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    nameLineView.backgroundColor = WGAppSeparateLineColor;
    [_nameTextField addSubview:nameLineView];
    
    _emailTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _nameTextField.maxY, textFieldWidth, textFieldHeight)];
    _emailTextField.font = kAppAdaptFont(14);
    _emailTextField.placeholder = kStr(@"Register_Email");
    _emailTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_emailTextField];
    
    JHView *emailLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    emailLineView.backgroundColor = WGAppSeparateLineColor;
    [_emailTextField addSubview:emailLineView];
    
    _passwordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _emailTextField.maxY, textFieldWidth, textFieldHeight)];
    _passwordTextField.font = kAppAdaptFont(14);
    _passwordTextField.placeholder = kStr(@"Register_Password");
    _passwordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_passwordTextField];
    
    JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    passwordLineView.backgroundColor = WGAppSeparateLineColor;
    [_passwordTextField addSubview:passwordLineView];
    
    _confirmPasswordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _passwordTextField.maxY, textFieldWidth, textFieldHeight)];
    _confirmPasswordTextField.font = kAppAdaptFont(14);
    _confirmPasswordTextField.placeholder = kStr(@"Register_Confirm_Password");
    _confirmPasswordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_confirmPasswordTextField];
    
    JHView *confirmPasswordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    confirmPasswordLineView.backgroundColor = WGAppSeparateLineColor;
    [_confirmPasswordTextField addSubview:confirmPasswordLineView];
    
    radius = kAppAdaptWidth(20);
    JHButton *registerBtn = [[JHButton alloc] initWithFrame:CGRectMake(textFieldX, _confirmPasswordTextField.maxY + kAppAdaptHeight(24), textFieldWidth, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
    [registerBtn setTitle:kStr(@"Register_Title") forState:UIControlStateNormal];
    [registerBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kAppAdaptFont(14);
    [registerBtn addTarget:self action:@selector(touchRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:registerBtn];
    
    JHButton *loginBtn = [[JHButton alloc] initWithFrame:CGRectMake(textFieldX, registerBtn.maxY + kAppAdaptHeight(22), textFieldWidth, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBaseColor];
    [loginBtn setTitle:kStr(@"Register_Title") forState:UIControlStateNormal];
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kAppAdaptFont(14);
    [loginBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginBtn];
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, loginBtn.maxY + kAppAdaptHeight(27));
}

- (void)touchReturnBtn:(JHButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchVerificationCodeBtn:(JHButton *)sender {
    WeakSelf;
    [[WGApplication sharedApplication] loadVerificationCodeUserName:_mobileTextField.text countryCode:_codeTextField.text onCompletion:^(WGGetVerifyCodeResponse *response) {
        [weakSelf showWarningMessage:response.message];
    }];
}

- (void)touchLoginBtn:(JHButton *)sender {
    [self openLoginViewController];
}

- (void)intoLoginViewController:(UIGestureRecognizer *)recognizer {
    [self openLoginViewController];
}

- (void)handleLoginSuccess:(id)customData {
    [self sendNotification:WGRefreshNotificationTypeLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogIn object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchWeChatBtn:(JHButton *)sender {

}

- (void)touchFaceBookBtn:(UIButton *)sender {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:true];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [loginManager setLoginBehavior:FBSDKLoginBehaviorNative];
    [loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (result) {
            [[WGApplication sharedApplication] loadCheckBind:result.token.tokenString type:WGThirdPartyLoginTypeFacebook onCompletion:^(WGCheckBindResponse *response) {
                [self handleCheckBind:response uniqueId:result.token.tokenString type:WGThirdPartyLoginTypeFacebook];
            }];
            NSLog(@"---------%@", result.token.tokenString);
        }
        else {
            NSLog(@"----------error---");
        }
    }];
}

- (void)handleCheckBind:(WGCheckBindResponse *)response uniqueId:(NSString *)uniqueId type:(WGThirdPartyLoginType)type {
    if (response == nil) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    
    if (response.unBind) {
        WGBindThirdPartyViewController *bindViewController = [[WGBindThirdPartyViewController alloc] init];
        bindViewController.uniqueId = uniqueId;
        bindViewController.type = type;
        [self.navigationController pushViewController:bindViewController animated:YES];
    }
    else if (response.bind) {
        [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)touchRegisterBtn:(JHButton *)sender {
    [self loadRegister];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
