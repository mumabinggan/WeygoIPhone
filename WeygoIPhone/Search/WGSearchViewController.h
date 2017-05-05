//
//  WGSearchViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGSearchResponse.h"
#import "WGHotSearchViewController.h"

@interface WGSearchViewController : WGViewController
{
    WGSearchData *_data;
    
    WGHotSearchViewController *_hotSearchViewController;
    
    JHTextField *_textFiled;
}

- (void)refreshUI;

@end
