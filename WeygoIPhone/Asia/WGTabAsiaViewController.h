//
//  WGAsiaViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGHome.h"
#import "WGHomeTabContentViewController.h"
#import "WGHomeTabContentResponse.h"

@interface WGTabAsiaViewController : WGTabViewController
{
    WGHome *_data;
    WGHomeTabContentViewController *_contentVC;
    
    WGHomeTabContentResponse *_dataResponse;
    BOOL _hadReadCache;
}

- (void)refreshUI;

@end
