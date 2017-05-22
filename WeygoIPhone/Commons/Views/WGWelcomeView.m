//
//  LFWelcomeView.m
//  LiFang
//
//  Created by Chris on 18/5/15.
//  Copyright (c) 2015 Lifang. All rights reserved.
//

#import "WGWelcomeView.h"
#import "JHPageControl.h"

#define WG_WELCOME_PAGE_NUM 3

@interface LFBoutiqueColumnPageControl : JHPageControl

@end

@implementation LFBoutiqueColumnPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDots];
}

- (void)layoutDots {
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView *dot = [self.subviews objectAtIndex:i];
        dot.size = CGSizeMake(kAppAdaptWidth(8), kAppAdaptHeight(8));
        if (i != self.currentPage) {
            dot.layer.borderColor = kHRGBA(0xffffff, 0.5).CGColor;
            dot.layer.borderWidth = 0;
            dot.backgroundColor = kHRGBA(0xffffff, 0.5);
        }
        else {
            dot.layer.borderColor = kWhiteColor.CGColor;
            dot.layer.borderWidth = 1.5;
            dot.backgroundColor = kClearColor;
        }
    }
}

@end

@interface WGWelcomeView (ScrollDelegate) <UIScrollViewDelegate>

@end

@implementation WGWelcomeView
{
    JHView *_backView;
    JHScrollView *_scrollView;
    LFBoutiqueColumnPageControl *_pageControl;
    int _currentPage;
    JHButton *_enterButton;
}

- (void)loadSubviews {
    [super loadSubviews];
    
    _backView = [[JHView alloc] initWithFrame:self.bounds];
    _backView.backgroundColor = kWhiteColor;
    [self addSubview:_backView];
    
    _scrollView = [[JHScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    for (int i = 0; i < WG_WELCOME_PAGE_NUM; ++i) {
        JHView *imageWrapperView = [[JHView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i , 0, kDeviceWidth, _scrollView.height)];
        imageWrapperView.layer.masksToBounds = YES;
        [_scrollView addSubview:imageWrapperView];
        int index = [JHLocalizableManager sharedManager].type;
        UIImage *image = [WGWelcomeView imagePNGWithDeferenceDevices:[NSString stringWithFormat:@"welcome%d", i+1]];
        if (i == WG_WELCOME_PAGE_NUM - 1) {
            NSInteger columns = 2, rows = 2;
            NSArray *images = [self getImagesFromImage:image withRow:rows withColumn:columns];
            CGFloat imageWidth = imageWrapperView.width / columns;
            CGFloat imageHeight = imageWrapperView.height / rows;
            for (NSInteger i = 0; i < images.count; ++i) {
                JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake((i % columns) * imageWidth, (i / columns) * imageHeight, imageWidth, imageHeight)];
                imageView.image = [images objectAtIndex:i];
                //imageView.layer.borderColor = kRandomColor.CGColor;
                //imageView.layer.borderWidth = kAppSepratorLineHeight;
                [imageWrapperView addSubview:imageView];
            }
            _enterButton = [JHButton buttonWithType:UIButtonTypeCustom];
            [_enterButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"enter-button_%d", index]] forState:UIControlStateNormal];
            CGFloat buttonWidth = imageWrapperView.width * 2.0 / 5.0;
            CGFloat buttonHeight = buttonWidth * 146.0 / 668.0;
            _enterButton.frame = CGRectMake((imageWrapperView.width - buttonWidth) / 2, imageWrapperView.height - buttonHeight - kAppAdaptHeight(80), buttonWidth, buttonHeight);
            [_enterButton addTarget:self action:@selector(handleEnterApp:) forControlEvents:UIControlEventTouchUpInside];
            [imageWrapperView addSubview:_enterButton];
        }
        else {
            JHImageView *imageView = [[JHImageView alloc] initWithImage:image];
            imageView.frame = imageWrapperView.bounds;
            [imageWrapperView addSubview:imageView];
        }
    }
    
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_scrollView.width * (WG_WELCOME_PAGE_NUM + 1), _scrollView.height);
    
    _pageControl = [[LFBoutiqueColumnPageControl alloc] init];
    CGRect pageRect ;
    if ([[JHDeviceManager sharedManager] iPhone35]) {
        pageRect = CGRectMake(0, self.height - 20 - 18, kDeviceWidth, 20);
    }
    else {
        pageRect = CGRectMake(0, self.height - 20 - kAppAdaptHeight(25), kDeviceWidth, 20);
    }
    _pageControl.frame = pageRect;
    _pageControl.numberOfPages = WG_WELCOME_PAGE_NUM;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.userInteractionEnabled = NO;
//    _pageControl.pageIndicatorTintColor = kHRGB(0xe4e4e4);
//    _pageControl.currentPageIndicatorTintColor = WGAppBaseColor;
//    _pageControl.currentPageIndicatorTintColor = kHRGBA(0xFFFFFF, 0.5);
//    _pageControl.pageIndicatorTintColor = WGAppBaseColor;
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
}

+ (UIImage *)imagePNGWithDeferenceDevices:(NSString *)imageName {
    return [self imageWithDeferenceDevice:imageName type:@"png"];
}

+ (UIImage *)imageJPGWithDeferenceDevices:(NSString *)imageName {
    return [self imageWithDeferenceDevice:imageName type:@"jpg"];
}

+ (UIImage *)imageWithDeferenceDevice:(NSString *)imageName type:(NSString *)type {
    NSString *newName = nil;
    int index = [JHLocalizableManager sharedManager].type;
    if ([[JHDeviceManager sharedManager] iPhone35]) {
        newName = [NSString stringWithFormat:@"%@-4s_%d.%@", imageName, index, type];
    }
    else if ([[JHDeviceManager sharedManager] iPhone40]) {
        newName = [NSString stringWithFormat:@"%@-5s_%d.%@", imageName, index, type];
    }
    else if ([[JHDeviceManager sharedManager] iPhone47]) {
        newName = [NSString stringWithFormat:@"%@-6s_%d.%@", imageName, index, type];
    }
    else if ([[JHDeviceManager sharedManager] iPhone55]) {
        newName = [NSString stringWithFormat:@"%@-6p_%d.%@", imageName, index, type];
    }
    return [UIImage imageNamed:newName];
}

-(NSMutableArray *)getImagesFromImage:(UIImage *)image withRow:(NSInteger)rows withColumn:(NSInteger)columns {
    NSMutableArray *images = [NSMutableArray array];
    CGSize imageSize = image.size;
    CGFloat xPos = 0.0, yPos = 0.0;
    CGFloat width = imageSize.width/rows;
    CGFloat height = imageSize.height/columns;
    for (int y = 0; y < columns; y++) {
        xPos = 0.0;
        for (int x = 0; x < rows; x++) {
            
            CGRect rect = CGRectMake(xPos, yPos, width, height);
            CGImageRef cImage = CGImageCreateWithImageInRect([image CGImage],  rect);
            
            UIImage *dImage = [[UIImage alloc] initWithCGImage:cImage];
            [images addObject:dImage];
            xPos += width;
        }
        yPos += height;
    }
    return images;
}

- (void)handleEnterApp:(JHButton *)sender {
    JHView *wrapperView = (JHView *)sender.superview;
    [sender removeFromSuperview];
    for (int i = 0; i < wrapperView.subviews.count; ++i) {
        JHImageView *imageView = [wrapperView.subviews objectAtIndex:i];
        [UIView animateWithDuration:(arc4random() % 25 + 25) / 100.0 animations:^{
            int x = ((i % 2) - ((i % 2)^1));
            int y = ((i / 2) - ((i / 2)^1));
            imageView.center = CGPointMake(x * wrapperView.width + (wrapperView.width / 2), y * wrapperView.height + (wrapperView.height / 2));
        } completion:^(BOOL finished) {
            
        }];
    }
    [UIView animateWithDuration:0.25 animations:^{
        _backView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        if (self.onCompletion) {
            self.onCompletion();
        }
    }];
}

- (void)handleTryNow:(JHButton *)sender {
    //[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    if (self.onCompletion) {
        self.onCompletion();
    }
}

- (void)startAnimation {
}

- (void)stopAnimation {
}

- (void)checkOpacity {
}

@end

@implementation WGWelcomeView (ScrollDelegate)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
    if (_currentPage >= 0 && _currentPage < WG_WELCOME_PAGE_NUM) {
        _pageControl.currentPage = _currentPage;
        [self checkOpacity];
        _pageControl.hidden = _currentPage == WG_WELCOME_PAGE_NUM - 1;
    }
    else if (_currentPage == WG_WELCOME_PAGE_NUM) {
        if (self.onCompletion) {
            self.onCompletion();
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
    if (_currentPage>=0 && _currentPage<WG_WELCOME_PAGE_NUM) {
        _pageControl.currentPage = _currentPage;
        [self checkOpacity];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    int nextPage = _currentPage;
    if((offset.x - _currentPage * scrollView.width) > 0){
        nextPage = _currentPage + 1;
    }
    else if((offset.x - _currentPage * scrollView.width) < 0) {
        nextPage = _currentPage - 1;
    }
    if (nextPage < 0) {
        nextPage = 0;
    }
    else if(nextPage >= WG_WELCOME_PAGE_NUM) {
        nextPage = WG_WELCOME_PAGE_NUM - 1;
    }
    if (nextPage != _currentPage) {
        _backView.backgroundColor = kWhiteColor;
    }
    else {
        if (nextPage == WG_WELCOME_PAGE_NUM - 1) {
            _backView.backgroundColor = kRGBA(255, 255, 255, 1- pow((offset.x - nextPage * _scrollView.width) / _scrollView.width, 3));
        }
        else {
            _backView.backgroundColor = kWhiteColor;
        }
    }
}

@end
