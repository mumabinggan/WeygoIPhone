//
//  WGAsiaViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGHome.h"

@interface WGSpecialClassifyViewController : WGViewController
{
    WGHome *_data;
}

@property (nonatomic, assign) long long id;

- (void)refreshUI;

@end
