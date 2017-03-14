//
//  WGCSCPlainTextViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCSCStyle1ViewController.h"
#import "WGCSCCommonItemResponse.h"
#import "WGCSCCommonItemRequest.h"

@interface WGCSCStyle1ViewController ()
{
    JHTextView *_textView;
}
@end

@interface WGCSCStyle1ViewController (Request)

- (void)loadCSCContent;

@end

@implementation WGCSCStyle1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCSCContent];
}

- (void)initSubView {
    _textView = [[JHTextView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(29), kDeviceWidth - kAppAdaptWidth(32), kDeviceHeight - kAppNavigationVCY - kAppAdaptHeight(58))];
    _textView.font = kAppAdaptFont(14);
    _textView.editable = NO;
    _textView.textColor = WGAppTitleColor;
    _textView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView];
    _textView.hidden = NO;
    _textView.text = @"FAQ有三种含义：1. 常见的问题项目与对应问题的解答；2、良好平均品质；3、FAQ检索系统。常见问题解答FAQ是英文Frequently Asked Questions的缩写，中文意思就是“经常问到的问题”，或者更通俗地叫做“常见问题解答”。 在很多网站上都可以看到FAQ，列出了一些用户常见的问题，是一种在线帮助形式。在..";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGCSCStyle1ViewController (Request)

- (void)loadCSCContent {
    WGCSCCommonItemRequest *request = [[WGCSCCommonItemRequest alloc] init];
    request.type = _type;
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGCSCCommonItemResponse class] success:^(JHResponse *response) {
        [weakSelf handleCSCContent:(WGCSCCommonItemResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleCSCContent:(WGCSCCommonItemResponse *)response {
    if (response.success) {
        _textView.text = response.data;
        _textView.hidden = NO;
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
