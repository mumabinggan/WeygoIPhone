//
//  WGPayWebViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/12.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPayWebViewController.h"
#import "WGPaySuccessViewController.h"

@interface WGPayWebViewController ()
{
    WGCommitOrderData *_orderData;
}
@end

@implementation WGPayWebViewController

- (id)initWithOrderData:(WGCommitOrderData *)data {
    self = [super initWithURLAddress:data.action];
    if (self) {
        _orderData = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    if (![NSString isNullOrEmpty:url] && [url containsString:_orderData.actionSuccess]) {
        WGPaySuccessViewController *vc = [[WGPaySuccessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
