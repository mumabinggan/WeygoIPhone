//
//  ViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testRoundButton1];
    
    [self testRoundView];
    
    JHLabel *label = [[JHLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    label.text = @"asdfasd";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)showload {
    [[JHAlert sharedAlert] showLoadingViewWithMessage:@"你好" inView:self.view];
}

- (void)showWarning {
    [[JHAlert sharedAlert] showWarningMessageInView:self.view message:@"瞄瞄"];
}

- (void)showAlert {
    [[JHAlert sharedAlert] showAlertMessage:@"你好" withTitle:@"你好，早上好"];
}

- (void)testRoundButton1 {
    JHButton *button = [[JHButton alloc] initWithFrame:CGRectMake(100, 50, 100, 50) difRadius:JHRadiusMake(5, 7, 10, 15) borderWidth:2 borderColor:kRedColor backgroundColor:kGreenColor];
    [self.view addSubview:button];
}

- (void)testRoundButton {
    CGRect frame = CGRectMake(0, 0, 300, 100);
    JHRadius difRadius1 = JHRadiusMake(30, 40, 20, 50);
    UIImage *image1 = [UIImage imageWithRect:frame roundedCorner:difRadius1 borderWidth:8 borderColor:[UIColor redColor] backgroundColor:[UIColor greenColor]];
    JHButton *button = [[JHButton alloc] initWithFrame:CGRectMake(50, 100, frame.size.width, frame.size.height)];
    [button setBackgroundImage:image1 forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)testSetWebImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    imageView.backgroundColor = kRedColor;
    [imageView setImageWithURL:[NSURL URLWithString:@"http://img2.a0bi.com/upload/ttq/20161005/1475660358092.jpg"] placeholderImage:nil options:SDWebImageRefreshCached];
    [self.view addSubview:imageView];
}

- (void)testRoundView3 {
    CGRect frame = CGRectMake(0, 0, 300, 200);
    JHRadius difRadius = JHRadiusMake(30, 40, 20, 50);
    JHView *view = [[JHView alloc] initWithFrame:frame difRadius:difRadius backgroundColor:kRedColor];
    [self.view addSubview:view];
}

- (void)testRoundView2 {
    CGRect frame = CGRectMake(0, 0, 300, 200);
    JHRadius difRadius = JHRadiusMake(30, 40, 20, 50);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view addCorner:difRadius borderWidth:2.0 borderColor:kRedColor backgroundColor:kGreenColor];
    [self.view addSubview:view];
}

- (void)testRoundView {
    CGRect frame = CGRectMake(0, 0, 300, 200);
    JHRadius difRadius1 = JHRadiusMake(30, 40, 20, 50);
    UIImage *image1 = [UIImage imageWithRect:frame roundedCorner:difRadius1 borderWidth:8 borderColor:[UIColor redColor] backgroundColor:[UIColor greenColor]];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    imageView1.frame = CGRectMake(50, 100, frame.size.width, frame.size.height);
    [self.view addSubview:imageView1];
}

- (void)testPerformSelector {
    [self performSelector:@selector(setHHH:ss:) withObjects:@"sd", [NSNull null], nil];
}

- (void)setHHH:(NSString *)string ss:(NSString *)s {
    NSLog(@"haha%@%@", string, s);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
