//
//  WGForgetPasswordViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGForgetPasswordViewController.h"
#import "WGForgetPasswordViewController+Request.h"
#import "WGVerificationCodeView.h"

@interface WGForgetPasswordViewController ()
{
    JHScrollView *_scrollView;
    
    WGVerificationCodeView *_verificationCodeBtn;
}
@end

@implementation WGForgetPasswordViewController

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
    titleLabel.text = kStr(@"ForgetPW_Title");
    titleLabel.font = kAppAdaptFont(16);
    titleLabel.textColor = kWhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    JHButton *returnBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(37), kAppAdaptWidth(20), kAppAdaptHeight(11))];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"app_return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(touchReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    JHImageView *headerImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, -20, kDeviceWidth, kAppAdaptHeight(164))];
    headerImageView.image = [UIImage imageNamed:@"forget_passwordHeadImage"];
    [_scrollView addSubview:headerImageView];
    
    JHImageView *countryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), headerImageView.maxY + kAppAdaptHeight(33), kAppAdaptWidth(18), kAppAdaptHeight(12))];
    countryImageView.image = [UIImage imageNamed:@"Italiana_image"];
    countryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:countryImageView];
    
    JHLabel *areaCodeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(64), headerImageView.maxY + kAppAdaptHeight(27), kAppAdaptWidth(60), kAppAdaptHeight(24))];
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
    _mobileTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32 + 105), headerImageView.maxY + kAppAdaptHeight(15), kDeviceWidth - kAppAdaptWidth(64 - 105), textFieldHeight)];
    _mobileTextField.font = kAppAdaptFont(14);
    _mobileTextField.placeholder = kStr(@"ForgetPW_Mobile");
    _mobileTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_mobileTextField];
    
    float lineY = _mobileTextField.height - kAppSepratorLineHeight;
    JHView *mobileLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, kDeviceWidth - kAppAdaptWidth(64), kAppSepratorLineHeight)];
    mobileLineView.backgroundColor = WGAppSeparateLineColor;
    [_mobileTextField addSubview:mobileLineView];
    
    _codeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _mobileTextField.maxY, textFieldWidth, textFieldHeight)];
    _codeTextField.font = kAppAdaptFont(14);
    _codeTextField.placeholder = kStr(@"ForgetPW_Code");
    _codeTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_codeTextField];
    
    WeakSelf;
    float radius = kAppAdaptHeight(12);
    _verificationCodeBtn = [[WGVerificationCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(191), kAppAdaptHeight(12), kAppAdaptWidth(120), kAppAdaptHeight(24))];
    _verificationCodeBtn.onApply = ^() {
        [weakSelf touchVerificationCodeBtn:nil];
    };
    [_codeTextField addSubview:_verificationCodeBtn];
    
    JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    codeLineView.backgroundColor = WGAppSeparateLineColor;
    [_codeTextField addSubview:codeLineView];
    
    _passwordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _codeTextField.maxY, textFieldWidth, textFieldHeight)];
    _passwordTextField.font = kAppAdaptFont(14);
    _passwordTextField.placeholder = kStr(@"ForgetPW_Password");
    _passwordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_passwordTextField];
    
    JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    passwordLineView.backgroundColor = WGAppSeparateLineColor;
    [_passwordTextField addSubview:passwordLineView];
    
    _confirmPasswordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _passwordTextField.maxY, textFieldWidth, textFieldHeight)];
    _confirmPasswordTextField.font = kAppAdaptFont(14);
    _confirmPasswordTextField.placeholder = kStr(@"ForgetPW_Confirm_Password");
    _confirmPasswordTextField.textColor = WGAppNameLabelColor;
    [_scrollView addSubview:_confirmPasswordTextField];
    
    JHView *confirmPasswordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
    confirmPasswordLineView.backgroundColor = WGAppSeparateLineColor;
    [_confirmPasswordTextField addSubview:confirmPasswordLineView];
    
    radius = kAppAdaptWidth(20);
    JHButton *findPasswordBtn = [[JHButton alloc] initWithFrame:CGRectMake(textFieldX, _confirmPasswordTextField.maxY + kAppAdaptHeight(24), textFieldWidth, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
    [findPasswordBtn setTitle:kStr(@"ForgetPW_Title") forState:UIControlStateNormal];
    [findPasswordBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    findPasswordBtn.titleLabel.font = kAppAdaptFont(14);
    [findPasswordBtn addTarget:self action:@selector(touchFindPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:findPasswordBtn];
    
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, findPasswordBtn.maxY + kAppAdaptHeight(27));
}

- (void)touchReturnBtn:(JHButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchVerificationCodeBtn:(JHButton *)sender {
    [self loadGetVerificationCode];
}

- (void)touchFindPasswordBtn:(JHButton *)sender {
    [self loadChangePassword];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
