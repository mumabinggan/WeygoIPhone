//
//  WGBindThirdPartyViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/7.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBindThirdPartyViewController.h"
#import "WGSegmentView.h"
#import "WGVerificationCodeView.h"
#import "PooCodeView.h"

@interface WGBindThirdPartyViewController ()
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_contentsScrollView;
    
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
    JHTextField *_unRegisterPasswordTextField;
    JHTextField *_confirmPasswordTextField;
    
    WGVerificationCodeView *_unRegisterVerificationCodeBtn;
}
@end

@interface WGBindThirdPartyViewController (ScrollViewDelegate)<UIScrollViewDelegate>

@end

@implementation WGBindThirdPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    [super initSubView];
    _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, kAppNavigationVCY, kDeviceWidth, kAppAdaptHeight(44))];
    [_titleSegmentView setTitleArray:@[kStr(@"ThirdPartyBing_HadRegister"), kStr(@"ThirdPartyBing_UnRegister")]];
    _titleSegmentView.backgroundColor = kWhiteColor;
    __weak id weakSelf = self;
    _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
        [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
    };
    [self.view addSubview:_titleSegmentView];
    
    _contentsScrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, kDeviceHeight - _titleSegmentView.maxY - kAppTabBarHeight)];
    _contentsScrollView.contentSize = CGSizeMake(2 * kDeviceWidth, kAppAdaptHeight(48 * 6 + 52 + 40 + 16));
    _contentsScrollView.showsHorizontalScrollIndicator = NO;
    _contentsScrollView.delegate = self;
    _contentsScrollView.pagingEnabled = YES;
    _contentsScrollView.bounces = NO;
    [self.view addSubview:_contentsScrollView];
    
    [self setContentsScrollViewOffsetWithIndex:0];
}

- (void)createRegisterView {
    if (!_registerView) {
        _registerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(48 * 3 + 16 + 25 + 40))];
        [_contentsScrollView addSubview:_registerView];
    
        _usernameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(64), kAppAdaptHeight(48))];
        _usernameTextField.font = kAppAdaptFont(14);
        _usernameTextField.placeholder = kStr(@"ThirdPartyBing_Mobile");
        _usernameTextField.textColor = WGAppNameLabelColor;
        [_registerView addSubview:_usernameTextField];
        
        float lineY = _usernameTextField.height - kAppSepratorLineHeight;
        JHView *usernameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
        usernameLineView.backgroundColor = WGAppSeparateLineColor;
        [_usernameTextField addSubview:usernameLineView];
        
        _passwordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(_usernameTextField.x, _usernameTextField.maxY, _usernameTextField.width, _usernameTextField.height)];
        _passwordTextField.font = kAppAdaptFont(14);
        _passwordTextField.placeholder = kStr(@"ThirdPartyBing_Password");
        _passwordTextField.textColor = WGAppNameLabelColor;
        _passwordTextField.secureTextEntry = YES;
        [_registerView addSubview:_passwordTextField];
        
        JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
        passwordLineView.backgroundColor = WGAppSeparateLineColor;
        [_passwordTextField addSubview:passwordLineView];
        
        _codeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(_usernameTextField.x, _passwordTextField.maxY, _usernameTextField.width, _usernameTextField.height)];
        _codeTextField.font = kAppAdaptFont(14);
        _codeTextField.placeholder = kStr(@"ThirdPartyBing_Code");
        _codeTextField.textColor = WGAppNameLabelColor;
        //[_registerView addSubview:_codeTextField];
        
        _verificationCodeBtn = [[PooCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(231), kAppAdaptHeight(8), kAppAdaptWidth(82), kAppAdaptHeight(32))];
        [_verificationCodeBtn addSingleTapGestureRecognizerWithTarget:self action:@selector(changeVerificationCode)];
        [_verificationCodeBtn setBackgroundColor:kGreenColor];
        //[_codeTextField addSubview:_verificationCodeBtn];
        
        JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _usernameTextField.width, kAppSepratorLineHeight)];
        codeLineView.backgroundColor = WGAppSeparateLineColor;
        //[_codeTextField addSubview:codeLineView];
        
        float radius = kAppAdaptWidth(20);
        JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, _codeTextField.maxY + kAppAdaptHeight(24), _usernameTextField.width, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
        [confirmBtn setTitle:kStr(@"ThirdPartyBing_Ok") forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = kAppAdaptFont(14);
        [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_registerView addSubview:confirmBtn];
    }
}

- (void)touchVerificationCodeBtn:(JHButton *)sender {
    
}

- (void)touchConfirmBtn:(JHButton *)sender {
    
}

- (void)createUnRegisterView {
    if (!_unRegisterView) {
        _unRegisterView = [[JHView alloc] initWithFrame:CGRectMake(kDeviceWidth, 0, kDeviceWidth, kAppAdaptHeight(560))];
        [_contentsScrollView addSubview:_unRegisterView];
        
        JHImageView *countryImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), kAppAdaptHeight(33), kAppAdaptWidth(18), kAppAdaptHeight(12))];
        countryImageView.image = [UIImage imageNamed:@"Italiana_image"];
        [_unRegisterView addSubview:countryImageView];
        
        JHLabel *areaCodeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(64), kAppAdaptHeight(27), kAppAdaptWidth(60), kAppAdaptHeight(24))];
        areaCodeLabel.text = @"+39";
        areaCodeLabel.textColor = WGAppLightNameLabelColor;
        areaCodeLabel.textAlignment = NSTextAlignmentCenter;
        areaCodeLabel.font = kAppAdaptFont(14);
        areaCodeLabel.layer.masksToBounds = YES;
        areaCodeLabel.layer.cornerRadius = kAppAdaptHeight(12);
        areaCodeLabel.backgroundColor = kHRGB(0xF8FAFA);
        areaCodeLabel.layer.borderColor = kHRGB(0xEBEFF0).CGColor;
        areaCodeLabel.layer.borderWidth = kAppAdaptWidth(1);
        [_unRegisterView addSubview:areaCodeLabel];
        
        float textFieldHeight = kAppAdaptHeight(48);
        float textFieldWidth = kDeviceWidth - kAppAdaptWidth(64);
        float textFieldX = kAppAdaptWidth(32);
        _mobileTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32 + 105), kAppAdaptHeight(15), kDeviceWidth - kAppAdaptWidth(64 + 105), textFieldHeight)];
        _mobileTextField.font = kAppAdaptFont(14);
        _mobileTextField.placeholder = kStr(@"Register_Mobile");
        _mobileTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_mobileTextField];
        
        float lineY = _mobileTextField.height - kAppSepratorLineHeight;
        JHView *mobileLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, _mobileTextField.width, kAppSepratorLineHeight)];
        mobileLineView.backgroundColor = WGAppSeparateLineColor;
        [_mobileTextField addSubview:mobileLineView];
        
        _unRegisterCodeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _mobileTextField.maxY, textFieldWidth, textFieldHeight)];
        _unRegisterCodeTextField.font = kAppAdaptFont(14);
        _unRegisterCodeTextField.placeholder = kStr(@"Register_Code");
        _unRegisterCodeTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_unRegisterCodeTextField];
        
        WeakSelf;
        float radius = kAppAdaptHeight(12);
        _unRegisterVerificationCodeBtn = [[WGVerificationCodeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(191), kAppAdaptHeight(12), kAppAdaptWidth(120), kAppAdaptHeight(24))];
        _unRegisterVerificationCodeBtn.onApply = ^(void) {
            [weakSelf touchVerificationCodeBtn:nil];
        };
        [_unRegisterCodeTextField addSubview:_unRegisterVerificationCodeBtn];
        
        JHView *codeLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
        codeLineView.backgroundColor = WGAppSeparateLineColor;
        [_unRegisterCodeTextField addSubview:codeLineView];
        
        _surnameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _unRegisterCodeTextField.maxY, textFieldWidth, textFieldHeight)];
        _surnameTextField.font = kAppAdaptFont(14);
        _surnameTextField.placeholder = kStr(@"Register_Cognome");
        _surnameTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_surnameTextField];
        
        JHView *surnameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
        surnameLineView.backgroundColor = WGAppSeparateLineColor;
        [_surnameTextField addSubview:surnameLineView];
        
        _nameTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _surnameTextField.maxY, textFieldWidth, textFieldHeight)];
        _nameTextField.font = kAppAdaptFont(14);
        _nameTextField.placeholder = kStr(@"Register_Name");
        _nameTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_nameTextField];
        
        JHView *nameLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
        nameLineView.backgroundColor = WGAppSeparateLineColor;
        [_nameTextField addSubview:nameLineView];
        
        _unRegisterCodeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _nameTextField.maxY, textFieldWidth, textFieldHeight)];
        _unRegisterCodeTextField.font = kAppAdaptFont(14);
        _unRegisterCodeTextField.placeholder = kStr(@"Register_Password");
        _unRegisterCodeTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_unRegisterCodeTextField];
        
        JHView *passwordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
        passwordLineView.backgroundColor = WGAppSeparateLineColor;
        [_unRegisterCodeTextField addSubview:passwordLineView];
        
        _confirmPasswordTextField = [[JHTextField alloc] initWithFrame:CGRectMake(textFieldX, _unRegisterCodeTextField.maxY, textFieldWidth, textFieldHeight)];
        _confirmPasswordTextField.font = kAppAdaptFont(14);
        _confirmPasswordTextField.placeholder = kStr(@"Register_Confirm_Password");
        _confirmPasswordTextField.textColor = WGAppNameLabelColor;
        [_unRegisterView addSubview:_confirmPasswordTextField];
        
        JHView *confirmPasswordLineView = [[JHView alloc] initWithFrame:CGRectMake(0, lineY, textFieldWidth, kAppSepratorLineHeight)];
        confirmPasswordLineView.backgroundColor = WGAppSeparateLineColor;
        [_confirmPasswordTextField addSubview:confirmPasswordLineView];
        
        radius = kAppAdaptWidth(20);
        JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(_usernameTextField.x, _confirmPasswordTextField.maxY + kAppAdaptHeight(24), textFieldWidth, kAppAdaptHeight(40)) difRadius:JHRadiusMake(radius, radius, radius, radius) backgroundColor:WGAppBlueButtonColor];
        [confirmBtn setTitle:kStr(@"ThirdPartyBing_Ok") forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = kAppAdaptFont(14);
        [confirmBtn addTarget:self action:@selector(touchConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_unRegisterView addSubview:confirmBtn];
    }
}

- (void)changeVerificationCode {
    [_verificationCodeBtn changeCode];
}

- (void)refreshkVerificationCode {
    //[_verificationCodeBtn setBackgroundImageWithURL:[NSURL URLWithString:_verificationCodeResponse.data] forState:UIControlStateNormal placeholderImage:kLoginVerificationCodePlaceholderImage options:JHWebImageOptionsLowPriority];
}

- (void)addContentsWithIndex:(NSInteger)selectedIndex {
    if (selectedIndex == 0) {
        [self createRegisterView];
    }
    else {
        [self createUnRegisterView];
    }
}

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount {
    _contentsScrollView.contentSize = CGSizeMake(kDeviceWidth * itemCount, _contentsScrollView.height);
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:0.5 animations:^(void) {
        _contentsScrollView.contentOffset = CGPointMake(selectedIndex * kDeviceWidth, 0);
    } completion:^(BOOL finished) {
        [self addContentsWithIndex:selectedIndex];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGBindThirdPartyViewController (ScrollViewDelegate)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex = ((int)(scrollView.contentOffset.x + 1)) / (int)kDeviceWidth;
    [_titleSegmentView setSelectedIndex:selectedIndex];
    [self addContentsWithIndex:selectedIndex];
}

@end
