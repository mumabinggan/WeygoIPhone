//
//  LFServiceLoadingView.m
//  LiFang
//
//  Created by yanmingxin on 15/12/8.
//  Copyright © 2015年 Lifang. All rights reserved.
//

#import "WGServiceLoadingView.h"
#import "JHDeviceManager.h"

@implementation WGServiceLoadingView{
    JHImageView * bgView;
    JHImageView * bgWhileView;
    JHImageView * logo;
    BOOL _isIphone4;
}

- (void)loadSubviews {
    [super loadSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeSelf:)
                                                 name:kNotificationServiceLoad object:nil];
    self.backgroundColor = kWhiteColor;
    [self setbg];
    [self startAnimation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationServiceLoad object:nil];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)removeSelf:(id)notification {
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.stopView) {
            self.stopView();
        }
    }];
}

- (void)setbg {
    bgView = [[JHImageView alloc] initWithFrame:self.bounds];
    [self addSubview:bgView];
    bgWhileView = [[JHImageView alloc] initWithFrame:self.bounds];
    [self addSubview:bgWhileView];
    NSString * resolution = @"1242_2208";
    _isIphone4 = NO;
    CGRect logoFrame = CGRectZero;
    if ([[JHDeviceManager sharedManager] iPhone35]) {
        _isIphone4 = YES;
        resolution = @"640_960";
        logoFrame = CGRectMake(0, 130.3/2.0, 164/2.0, 219/2.0);
        //logoFrame = CGRectMake(0, 130.3/2.0, 74/2.0, 219/2.0);
    }
    else if ([[JHDeviceManager sharedManager] iPhone40]) {
//        resolution = @"640_1136";
        logoFrame = CGRectMake(0, 213/2.0, 164/2.0, 219/2.0);
        //logoFrame = CGRectMake(0, 213/2.0, 74/2.0, 219/2.0);
    }
    else if ([[JHDeviceManager sharedManager] iPhone47]) {
//        resolution = @"750_1334";
        logoFrame = CGRectMake(0, 248/2, 191/2.0, 257/2.0);
        //logoFrame = CGRectMake(0, 248/2, 101/2.0, 257/2.0);
    }
    else if ([[JHDeviceManager sharedManager] iPhone55]) {
//        resolution = @"1242_2208";
        logoFrame = CGRectMake(0, 414/3, 316/3.0, 422/3.0);
        //logoFrame = CGRectMake(0, 414/3, 226/3.0, 422/3.0);
    }
    
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"service_bg_%@",resolution] ofType:@"jpg"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    bgView.image = image;
    
    NSString * path2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"service_bg_while_%@",resolution] ofType:@"jpg"];
    UIImage * image2 = [UIImage imageWithContentsOfFile:path2];
    bgWhileView.image = image2;
    
    
    logo = [[JHImageView alloc] initWithFrame:logoFrame];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.clipsToBounds = YES;
    [self addSubview:logo];
    CGPoint center = logo.center;
    center.y -= 1;
    center.x = CGRectGetWidth(self.frame)/2-1;
    logo.center = center;
    NSString * path3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"service_logo_%@",resolution] ofType:@"png"];
    UIImage * image3 = [UIImage imageWithContentsOfFile:path3];
    logo.image = image3;
}

- (void)startAnimation {
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.duration = 6;
    group.repeatCount = INT_MAX;
    
    group.animations = [NSArray arrayWithObjects:[self createScaleAnimation],[self createOpacityAnimationForMode:YES], nil];
    [bgView.layer addAnimation:group forKey:@"bgViewAnimation"];
    
    CAAnimationGroup* group2 = [CAAnimationGroup animation];
    group2.duration = 6;
    group2.repeatCount = INT_MAX;
    
    group2.animations = [NSArray arrayWithObjects:[self createScaleAnimation],[self createOpacityAnimationForMode:NO], nil];
    [bgWhileView.layer addAnimation:group2 forKey:@"bgWhileViewAnimation"];
    
    CAKeyframeAnimation *opacityAnimation = [self createOpacityAnimationForMode:NO];
    opacityAnimation.duration = 6.0;
    opacityAnimation.repeatCount = INT_MAX;
    [logo.layer addAnimation:opacityAnimation forKey:@"logoViewAnimation"];
}

- (void)stopAnimation {
    [bgView.layer removeAllAnimations];
    [bgWhileView.layer removeAllAnimations];
    [logo.layer removeAllAnimations];
}

-(CAKeyframeAnimation *)createScaleAnimation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1, 1, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.05, 1.05, 1);
    CATransform3D scale3 = CATransform3DMakeScale(1, 1, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            nil];
    
    [animation setValues:frameValues];
    
    return animation;
}

-(CAKeyframeAnimation *)createOpacityAnimationForMode:(BOOL)mode {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    NSNumber * opacity1 = [NSNumber numberWithFloat:1.0];
    NSNumber * opacity2 = [NSNumber numberWithFloat:0.0];
    NSArray *frameValues = nil;
    if (mode) {
        frameValues = [NSArray arrayWithObjects:opacity2,opacity1,opacity2, nil];
    }
    else {
        frameValues = [NSArray arrayWithObjects:opacity1,opacity2,opacity1, nil];
    }
    [animation setValues:frameValues];
    
    return animation;
}

@end
