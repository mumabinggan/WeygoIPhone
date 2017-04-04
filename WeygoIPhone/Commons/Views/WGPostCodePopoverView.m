//
//  WGPostCodePopoverView.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/29.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPostCodePopoverView.h"

@implementation WGPostCodePopoverView
{
    UIView *_contentView;
    JHTextField *_postCodeTextField;
    JHLabel *_tipLabel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _contentView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(249), kAppAdaptHeight(268)) radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kHRGBA(0xF8FAFA, 0.88);
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    JHImageView *bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(101), kAppAdaptHeight(16), kAppAdaptWidth(46), kAppAdaptWidth(62))];
    bgImageView.image = [UIImage imageNamed:@"classifyDetail_sub_bg"];
    [_contentView addSubview:bgImageView];
    
    JHLabel *desLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(89), _contentView.width, kAppAdaptHeight(40))];
    desLabel.font = kAppAdaptFont(14);
    desLabel.text = kStr(@"Insert_Cap_Des");
    desLabel.numberOfLines = 2;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textColor = WGAppLightNameLabelColor;
    [_contentView addSubview:desLabel];
    
    _postCodeTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(21), kAppAdaptHeight(145), _contentView.width - kAppAdaptWidth(42), kAppAdaptHeight(32))];
    _postCodeTextField.font = kAppAdaptFont(14);
    _postCodeTextField.placeholderColor = WGAppLightNameLabelColor;
    _postCodeTextField.textColor = WGAppNameLabelColor;
    _postCodeTextField.textAlignment = NSTextAlignmentCenter;
    _postCodeTextField.backgroundColor = kWhiteColor;
    _postCodeTextField.placeholder = kStr(@"Insert_Cap");
    _postCodeTextField.enabled = YES;
    [_postCodeTextField becomeFirstResponder];
    _postCodeTextField.placeholderAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:_postCodeTextField];
    
    _tipLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _postCodeTextField.maxY + kAppAdaptHeight(3), _contentView.width, kAppAdaptHeight(40))];
    _tipLabel.font = kAppAdaptFont(12);
    _tipLabel.textColor = kHRGB(0xFF2600);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.hidden = YES;
    _tipLabel.text = kStr(@"Insert_Cap_Error");
    _tipLabel.numberOfLines = 2;
    [_contentView addSubview:_tipLabel];
    
    JHButton *comfirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(40), kAppAdaptHeight(223), _contentView.width - kAppAdaptWidth(80), kAppAdaptHeight(32)) difRadius:JHRadiusMake(kAppAdaptWidth(16), kAppAdaptWidth(16), kAppAdaptWidth(16), kAppAdaptWidth(16)) backgroundColor:WGAppFooterButtonColor];
    [comfirmBtn setTitle:kStr(@"Confirm") forState:UIControlStateNormal];
    comfirmBtn.titleLabel.font = kAppAdaptFont(14);
    [comfirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(touchComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:comfirmBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(changeHidden:)  name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchCloseBtn:(JHButton *)sender {
    [self close];
}

- (void)touchComfirmBtn:(id)sender {
    if ([[WGApplication sharedApplication] supportPostcode:_postCodeTextField.text]) {
        [WGApplication sharedApplication].currentPostCode = _postCodeTextField.text;
        _tipLabel.hidden = YES;
        if (self.onApply) {
            self.onApply(_postCodeTextField.text);
        }
        [self close];
        [_postCodeTextField resignFirstResponder];
    }
    else {
        _tipLabel.hidden = NO;
    }
}

- (void)changeContentViewPoint:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _contentView.center = CGPointMake(_contentView.center.x, keyBoardEndY - _contentView.bounds.size.height/2.0);
    }];
}

- (void)changeHidden:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2.0);
    }];
}

@end
