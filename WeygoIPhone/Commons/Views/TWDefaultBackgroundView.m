//
//  TWNoDataView.m
//  LiFang
//
//  Created by Hugo Wang on 15/11/5.
//  Copyright © 2015年 Lifang. All rights reserved.
//

#import "TWDefaultBackgroundView.h"

@implementation TWDefaultBackgroundView
{
    UITapGestureRecognizer *_tapGesture;
    JHImageView *_imageView;
    JHLabel *_titleLabel, *_subTitleLabel;
    JHButton *_btn;
    JHView *_containerView;
}


#pragma mark - Convenience Initializer

+ (TWDefaultBackgroundView *)defaultBackgroundViewWithType:(TWDefaultBackgroundViewType)tpye image:(UIImage *)image title:(NSString *)title subTitle:(NSString *)subTitle btnTitle:(NSString *)btnTitle completion:(void(^)())completion {
    TWDefaultBackgroundView *view = [[TWDefaultBackgroundView alloc] init];
    view.defaultViewType = tpye;
    view.image = image;
    view.title = title;
    view.subTitle = subTitle;
    view.btnTitle = btnTitle;
    view.onApply = ^{
        if (completion) {
            completion();
        }
    };
    return view;
}


#pragma mark - Life Cycle

- (void) dealloc {
    _onApply = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - UI Helper

- (void)setupUI {
    
    _containerView = [[JHView alloc] init];
    _containerView.backgroundColor = kClearColor;
    [self addSubview:_containerView];
    
    _imageView = [[JHImageView alloc] init];
    _imageView.contentMode = UIViewContentModeBottom;
    [_containerView addSubview:_imageView];
    
    _titleLabel = [[JHLabel alloc] init];
    _titleLabel.font = kAppAdaptFont(16);
    _titleLabel.textColor = WGAppNameLabelColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_containerView addSubview:_titleLabel];

    _subTitleLabel = [[JHLabel alloc] init];
    _subTitleLabel.font = kAppAdaptFont(16);
    _subTitleLabel.textColor = kHRGB(0x999999);
    _subTitleLabel.numberOfLines = 1;
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_containerView addSubview:_subTitleLabel];

    _btn = [[JHButton alloc] init];
    [_btn addTarget:self action:@selector(clickOnBtn) forControlEvents:UIControlEventTouchUpInside];
    _btn.titleLabel.font = kAppAdaptFont(14);
    [_btn setTitleColor:kHRGB(0x92a7c3) forState:UIControlStateNormal];
    [_btn setBackgroundColor:kHRGB(0xf6f6f6)];
    //[_btn setBackgroundColor:kHRGB(0xf6f6f6) forState:UIControlStateNormal];
    [_containerView addSubview:_btn];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToReload)];
    [self addGestureRecognizer:_tapGesture];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (_defaultViewType) {
        case TWDefaultBackgroundViewNoData: {
            [self setFramesWithNoDataType];
            break;
        }
        case TWDefaultBackgroundViewRequestError: {
            [self setFramesWithRequstErrorType];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)setFramesWithNoDataType {
    CGSize imageSize = _imageView.image.size;
    CGFloat imageViewW = imageSize.width;
    CGFloat imageViewH = imageSize.height;
    CGFloat padding = kAppAdaptWidth(10);
    CGFloat labelH = kAppAdaptHeight(18);
    CGFloat imageAndLabelsH = imageViewH + labelH * 2;
    CGFloat height = self.height - imageAndLabelsH;
    _imageView.frame = CGRectMake((kDeviceWidth - imageViewW) * 0.5,  height / 3.0, imageViewW, imageViewH);
    
    CGFloat spaceY = height / 9;
    _titleLabel.frame = CGRectMake(padding, _imageView.maxY + spaceY, (kDeviceWidth - 2 * padding), labelH);
    CGFloat labelSpace = kAppAdaptHeight(10);
    _subTitleLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.maxY + labelSpace, _titleLabel.width, labelH);
    
    CGFloat btnW = kDeviceWidth - kAppAdaptWidth(30);
    CGFloat btnH = (int)kAppAdaptHeight(45);
    _btn.frame = CGRectMake((kDeviceWidth - btnW) * 0.5, self.maxY - btnH - kAppAdaptHeight(20), btnW, btnH);
    _btn.layer.cornerRadius = kAppAdaptWidth(3);
    _btn.layer.masksToBounds = YES;
    
    _containerView.frame = CGRectMake(0, 0, self.width, self.height);
    _containerView.y -= _verticalOffset;
}

- (void)setFramesWithRequstErrorType {
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageViewW = imageSize.width;
    CGFloat imageViewH = imageSize.height;
    _imageView.frame = CGRectMake((kDeviceWidth - imageViewW) * 0.5, 0, imageViewW, imageViewH);
    
    CGFloat padding = kAppAdaptWidth(10);
    CGFloat labelH = kAppAdaptHeight(18);
    _titleLabel.frame = CGRectMake(padding, _imageView.maxY + kAppAdaptHeight(55), (kDeviceWidth - 2 * padding), labelH);
    
    _subTitleLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.maxY + 14, _titleLabel.width, labelH);
    
    CGFloat containViewH = _subTitleLabel.maxY;
    _containerView.frame = CGRectMake(0, 0, kDeviceWidth, containViewH);
    _containerView.midY = self.midY;
    _containerView.y -= _verticalOffset;
}


#pragma mark - Event Response

- (void)tapToReload {
    if (_defaultViewType != TWDefaultBackgroundViewRequestError) return;
    if (self.onApply) {
        self.onApply();
    }
}

- (void)clickOnBtn {
    if (_defaultViewType != TWDefaultBackgroundViewNoData) return;
    if (self.onApply) {
        self.onApply();
    }
}


#pragma mark - Setter And Getter

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
    [self layoutIfNeeded];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleLabel.text = _subTitle;
}

- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    
    if ([NSString isNullOrEmpty:_btnTitle]) {
        _btn.hidden = YES;
    } else {
        _btn.hidden = NO;
        [_btn setTitle:btnTitle forState:UIControlStateNormal];
    }
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    _verticalOffset = verticalOffset;
    [self layoutIfNeeded];
}

- (void)setBtnBackgroundColor:(UIColor *)btnBackgroundColor {
    _btnBackgroundColor = btnBackgroundColor;
    [_btn setBackgroundColor:btnBackgroundColor];
    //[_btn setBackgroundColor:btnBackgroundColor forState:UIControlStateNormal];
}

- (void)setBtnTitleColor:(UIColor *)btnTitleColor {
    _btnTitleColor = btnTitleColor;
    [_btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
}

@end
