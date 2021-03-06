//
//  WGLoginViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGLoginViewController.h"
#import "WGLoginViewController+Request.h"
#import "WGRegisterViewController.h"
#import "WGForgetPasswordViewController.h"
#import "PooCodeView.h"
#import "WGNavigationController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "WGBindThirdPartyViewController.h"

@interface WGLoginViewController ()
{
    JHScrollView *_scrollView;
    
    JHTextField *_usernameTextField;
    JHTextField *_passwordTextField;
    JHTextField *_codeTextField;
    PooCodeView *_verificationView;
}
@end

@implementation WGLoginViewController

- (BOOL)prefersNavigationBarHidden {
    return YES;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestVerificationCode];
}

- (void)initSubView {
    _scrollView = [[JHScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(30), kDeviceWidth, kAppAdaptHeight(24))];
    titleLabel.text = kStr(@"Login_Title");
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
    
    JHLabel *registerLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(86), kAppAdaptHeight(30), kAppAdaptWidth(70), kAppAdaptHeight(24))];
    registerLabel.text = kStr(@"Login_Register");
    registerLabel.font = kAppAdaptFont(16);
    registerLabel.textColor = kWhiteColor;
    registerLabel.textAlignment = NSTextAlignmentRight;
    registerLabel.userInteractionEnabled = YES;
    [self.view addSubview:registerLabel];
    [registerLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(openRegisterViewController)];
    
    JHImageView *headerImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, -20, kDeviceWidth, kAppAdaptHeight(264))];
    headerImageView.image = [UIImage imageNamed:@"register_headImage"];
    [_scrollView addSubview:headerImageView];
    
    _usernameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), headerImageView.maxY + kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(64), kAppAdaptHeight(48))];
    _usernameTextField.font = kAppAdaptFont(14);
    _usernameTextField.placeholder = kStr(@"Login_UserName");
    _usernameTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_usernameTextField];
    
    float lineY = _usernameTextField.height - kAppSepratorLineHeight;
    JHView *usernameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
    usernameLineView.backgroundColor = WGAppSeparateLineColor;
    [_usernameTextField addSubview:usernameLineView];
    
    _passwordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(_usernameTextField.x, _usernameTextField.maxY, _usernameTextField.width, _usernameTextField.height)];
    _passwordTextField.font = kAppAdaptFont(14);
    _passwordTextField.placeholder = kStr(@"Login_PW");
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_passwordTextField];
    
    JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
    passwordLineView.backgroundColor = WGAppSeparateLineColor;
    [_passwordTextField addSubview:passwordLineView];
    
    _codeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(_usernameTextField.x, _passwordTextField.maxY, _usernameTextField.width, _usernameTextField.height)];
    _codeTextField.font = kAppAdaptFont(14);
    _codeTextField.placeholder = kStr(@"Login_ValidCode");
    _codeTextField.textColor = WGAppNameLabelColor;
    //[_scrollView addSubview:_codeTextField];
    //_pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(50, 100, 82, 32)];
    _verificationView = [[PooCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(231), kAppAdaptHeight(8), kAppAdaptWidth(82), kAppAdaptHeight(32))];
    [_codeTextField addSubview:_verificationView];
    [_verificationView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchVerificationCodeView:)];
    
    JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
    codeLineView.backgroundColor = WGAppSeparateLineColor;
    //[_codeTextField addSubview:codeLineView];
    
    NSString *forgetString = kStr(@"Login_ForgetPW");
    float width = [forgetString returnSize:kAppAdaptFont(12)].width + 10;
    JHButton *forgetBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, _passwordTextField.maxY + kAppAdaptHeight(10), width, kAppAdaptHeight(17))];
    [forgetBtn setTitle:forgetString forState:UIControlStateNormal];
    [forgetBtn setTitleColor:WGAppLightNameLabelColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = kAppAdaptFont(12);
    [forgetBtn addTarget:self action:@selector(touchForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:forgetBtn];
    
    float radius = kAppAdaptWidth(20);
    JHButton *loginBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, _codeTextField.maxY + kAppAdaptHeight(24), _usernameTextField.width, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
    [loginBtn setTitle:kStr(@"Login_Title") forState:UIControlStateNormal];
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kAppAdaptFont(14);
    [loginBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginBtn];
    
    JHButton *registerBtn = [[JHButton alloc] initWithFrame:CGRectMake(loginBtn.x, loginBtn.maxY + kAppAdaptHeight(20), loginBtn.width, loginBtn.height) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBaseColor];
    [registerBtn setTitle:kStr(@"Login_Register") forState:UIControlStateNormal];
    [registerBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kAppAdaptFont(14);
    [registerBtn addTarget:self action:@selector(touchRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:registerBtn];
    
    radius = kAppAdaptWidth(20);
    JHButton *wechatBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, loginBtn.maxY + kAppAdaptHeight(100), kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    [wechatBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Login_WeChat")] forState:UIControlStateNormal];
    [wechatBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = kAppAdaptFont(14);
    [wechatBtn setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    wechatBtn.hidden = YES;
    [_scrollView addSubview:wechatBtn];
    
//    JHButton *facebookBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2 + kAppAdaptWidth(8), wechatBtn.y, kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    JHButton *facebookBtn = [[JHButton alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(200))/2, wechatBtn.y, kAppAdaptWidth(200), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    [facebookBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Login_FaceBook")] forState:UIControlStateNormal];
    [facebookBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    facebookBtn.titleLabel.font = kAppAdaptFont(14);
    [facebookBtn setImage:[UIImage imageNamed:@"login_facebook"] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(touchFaceBookBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:facebookBtn];
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, facebookBtn.maxY + kAppAdaptHeight(32));
}

- (void)touchReturnBtn:(JHButton *)sender {
    //返回
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)touchRegisterBtn:(JHButton *)sender {
    [self openRegisterViewController];
}

- (void)openRegisterViewController {
    //进入注册页面
    WGRegisterViewController *registerViewController = [[WGRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)touchVerificationCodeView:(UIGestureRecognizer *)recognizer {
    [_verificationView changeCode];
}

- (void)touchLoginBtn:(JHButton *)sender {
    NSString *username = _usernameTextField.text;
    if ([NSString isNullOrEmpty:username]) {
        [self showWarningMessage:kStr(@"Login_Tip_Email")];
        return;
    }
    NSString *password = _passwordTextField.text;
    if ([NSString isNullOrEmpty:password]) {
        [self showWarningMessage:kStr(@"Login_Tip_PW")];
        return;
    }
//    NSString *code = _codeTextField.text;
//    if ([NSString isNullOrEmpty:code]) {
//        [self showWarningMessage:kStr(@"Login_Tip_ValidCode")];
//        return;
//    }
//    if (NSOrderedSame != [_verificationView.changeString caseInsensitiveCompare:_codeTextField.text]) {
//        [self showWarningMessage:kStr(@"Login_Tip_ValidCode2")];
//        return;
//    }
    WGLoginRequest *loginRequest = [[WGLoginRequest alloc] init];
    loginRequest.username = [username trim];
    loginRequest.password = [password trim];
    loginRequest.showsLoadingView = YES;
    if (_from == WGLoginFromShopCart) {
//        loginRequest.cap = [WGApplication sharedApplication].currentPostCode;
//        loginRequest.shopCarts = [WGApplication sharedApplication].getGoodsInLocalCart;
    }
    [self requestLogin:loginRequest];
}

- (void)touchForgetBtn:(JHButton *)sender {
    WGForgetPasswordViewController *forgetPasswordViewController = [[WGForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

- (void)touchWeChatBtn:(JHButton *)sender {
    
    //[WGApplication sharedApplication] loadCheckBind:<#(NSString *)#> type:<#(WGThirdPartyLoginType)#> onCompletion:<#^(WGCheckBindResponse *)completion#>
}

- (void)touchFaceBookBtn:(JHButton *)sender {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:true];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [loginManager setLoginBehavior:FBSDKLoginBehaviorNative];
    [loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (result) {
            [[WGApplication sharedApplication] loadCheckBind:result.token.userID type:WGThirdPartyLoginTypeFacebook onCompletion:^(WGCheckBindResponse *response) {
                [self handleCheckBind:response uniqueId:result.token.userID type:WGThirdPartyLoginTypeFacebook];
            }];
            //NSLog(@"---------%@", result.token.tokenString);
        }
        else {
            //NSLog(@"----------error---");
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

- (void)refreshkVerificationCode {

}

+ (void)pushInNavigationController:(UINavigationController *)navigationController loginFrom :(WGLoginFrom)loginFrom sucess:(WGLoginSuccessBlock)successBlock cancel:(WGLoginCancelBlock)cancelBlock {
    WGLoginViewController *loginVC = [[WGLoginViewController alloc] init];
    loginVC.from = loginFrom;
    loginVC.cancelBlock = cancelBlock;
    loginVC.successBlock = successBlock;
    [navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
