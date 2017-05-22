//
//  WGScrollImageView.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/11.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGScrollImageView.h"
#import "WGPageControl.h"

@interface WGScrollImageView ()
{
    UIScrollView *_scrollView;
    BOOL _isInit;
    BOOL _haveSetOffset;
    
    UIPageControl *_pageControl;
    
    NSTimer *_timer;
}
@end

@interface WGScrollImageView (ScrollViewDelegate) <UIScrollViewDelegate>

@end

@implementation WGScrollImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    self = [self initWithFrame:frame];
    if (self) {
        [self setImageArray:imageArray];
    }
    return self;
}

- (void)initSubView {
    JHView *view = [[JHView alloc] initWithFrame:self.bounds];
    [self addSubview:view];
    
    _isInit = YES;
    _haveSetOffset = NO;
 
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];

    _pageControl = [[WGPageControl alloc] initWithFrame:CGRectMake(0, self.height - 30, 320, 20)];
    _pageControl.currentPageIndicatorTintColor = kHRGBA(0xFFFFFF, 0.5);
    _pageControl.pageIndicatorTintColor = kHRGBA(0xFFFFFF, 0.5);
    _pageControl.hidesForSinglePage = YES;
//    _pageControl.center = CGPointMake(self.width / 2, _scrollView.height - 20);
//    _pageControl.bounds = CGRectMake(0, 0, self.width, 20);
//    _pageControl.numberOfPages = 2;
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
}

- (void)setImageArray:(NSArray *)imageArray {
    if (imageArray.count == 0) {
        return;
    }
    NSMutableArray *newImageArray = [[NSMutableArray alloc] init];
    [newImageArray addObject:[imageArray lastObject]];
    [newImageArray addObjectsFromArray:imageArray];
    [newImageArray addObject:[imageArray firstObject]];
    
    CGRect frame = _scrollView.frame;
    for (int num = 0; num < newImageArray.count; num++) {
        frame.origin.x = CGRectGetWidth(_scrollView.frame) * (num);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setImageWithURL:newImageArray[num] placeholderImage:kHomeCarouselPictureHeaderPlaceholderImage options:JHWebImageOptionsRetryFailed|JHWebImageOptionsRefreshCached];
        imageView.userInteractionEnabled = YES;
        [imageView addSingleTapGestureRecognizerWithTarget:self action:@selector(touchImage:)];
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentOffset = CGPointMake(kDeviceWidth, 0);
    _scrollView.contentSize = CGSizeMake((newImageArray.count) * _scrollView.width, _scrollView.height);
    
    _pageControl.numberOfPages = imageArray.count;
    [_pageControl setNumberOfPages:imageArray.count];
    frame = _pageControl.frame;
    frame.size.width = self.width;
    //_pageControl.frame = frame;
    _pageControl.currentPage = 0;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    else {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer *timer) {
//            [weakSelf handleTimer:timer];
//        }];
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
}

- (void)touchImage:(UIGestureRecognizer *)recognizer {
    if (self.onClick) {
        self.onClick(_pageControl.currentPage);
    }
}

- (void)handleTimer:(NSTimer *)timer {
    CGPoint point = _scrollView.contentOffset;
    point.x += kDeviceWidth;
    if (point.x >= (_pageControl.numberOfPages+2) * kDeviceWidth) {
        point.x = kDeviceWidth;
        [_scrollView setContentOffset:point animated:NO];
        _pageControl.currentPage = ((_scrollView.contentOffset.x + 1) / kDeviceWidth) - 1;
    }
    else {
        [_scrollView setContentOffset:point animated:YES];
        _pageControl.currentPage = ((_scrollView.contentOffset.x + 1) / kDeviceWidth);
    }
}

- (void)removeFromSuperview {
    [_timer invalidate];
    _timer = nil;
    [super removeFromSuperview];
}

@end

@implementation WGScrollImageView (ScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isInit) {
        _isInit = NO;
        return;
    }
    if (scrollView.contentOffset.x / kDeviceWidth >= (_pageControl.numberOfPages + 1) - 0.0001) {
        _haveSetOffset = YES;
        [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    if (scrollView.contentOffset.x < 10) {
        _haveSetOffset = YES;
        [_scrollView setContentOffset:CGPointMake(kDeviceWidth * _pageControl.numberOfPages, 0) animated:NO];
        _pageControl.currentPage = _pageControl.numberOfPages - 1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_haveSetOffset) {
        _haveSetOffset = NO;
        return;
    }
    NSInteger curIndex = (int)((scrollView.contentOffset.x + 1) / kDeviceWidth);
    _pageControl.currentPage = curIndex - 1;
}

@end
