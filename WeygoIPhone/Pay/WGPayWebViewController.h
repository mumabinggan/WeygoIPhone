//
//  WGPayWebViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/12.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHWebViewController.h"
#import "WGCommitOrderResponse.h"

@interface WGPayWebViewController : JHWebViewController

- (id)initWithOrderData:(WGCommitOrderData *)data;

@end
