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
    _passwordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_passwordTextField];
    
    JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
    passwordLineView.backgroundColor = WGAppSeparateLineColor;
    [_passwordTextField addSubview:passwordLineView];
    
    _codeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(_usernameTextField.x, _passwordTextField.maxY, _usernameTextField.width, _usernameTextField.height)];
    _codeTextField.font = kAppAdaptFont(14);
    _codeTextField.placeholder = kStr(@"Login_ValidCode");
    _codeTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_codeTextField];
    //_pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(50, 100, 82, 32)];
    _verificationView = [[PooCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(231), kAppAdaptHeight(8), kAppAdaptWidth(82), kAppAdaptHeight(32))];
    [_codeTextField addSubview:_verificationView];
    [_verificationView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchVerificationCodeView:)];
    
    JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
    codeLineView.backgroundColor = WGAppSeparateLineColor;
    [_codeTextField addSubview:codeLineView];
    
    float radius = kAppAdaptWidth(20);
    JHButton *loginBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, _codeTextField.maxY + kAppAdaptHeight(24), _usernameTextField.width, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
    [loginBtn setTitle:kStr(@"Login_Title") forState:UIControlStateNormal];
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kAppAdaptFont(14);
    [loginBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginBtn];
    
    JHButton *forgetBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, loginBtn.maxY + kAppAdaptHeight(14), _usernameTextField.width, kAppAdaptHeight(14))];
    [forgetBtn setTitle:kStr(@"Login_ForgetPW") forState:UIControlStateNormal];
    [forgetBtn setTitleColor:WGAppLightNameLabelColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = kAppAdaptFont(12);
    [forgetBtn addTarget:self action:@selector(touchForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:forgetBtn];
    
    radius = kAppAdaptWidth(20);
    JHButton *wechatBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, forgetBtn.maxY + kAppAdaptHeight(77), kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
    [wechatBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Login_WeChat")] forState:UIControlStateNormal];
    [wechatBtn setTitleColor:WGAppTitleColor forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = kAppAdaptFont(14);
    [wechatBtn setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:wechatBtn];
    
    JHButton *facebookBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2 + kAppAdaptWidth(8), wechatBtn.y, kAppAdaptWidth(147), kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0xEBEFF0) backgroundColor:kHRGB(0xF8FAFA)];
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
    NSString *code = _codeTextField.text;
    if ([NSString isNullOrEmpty:code]) {
        [self showWarningMessage:kStr(@"Login_Tip_ValidCode")];
        return;
    }
    if (![_verificationView.changeString isEqualToString:_codeTextField.text]) {
        [self showWarningMessage:kStr(@"Login_Tip_ValidCode2")];
        return;
    }
    WGLoginRequest *loginRequest = [[WGLoginRequest alloc] init];
    loginRequest.username = username;
    loginRequest.password = password;
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

}

- (void)touchFaceBookBtn:(JHButton *)sender {
    
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
