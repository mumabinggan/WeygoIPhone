//
//  WGClassifyGoodListViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGClassifyGoodList.h"

@interface WGClassifyGoodListViewController : WGViewController
{
    WGClassifyGoodList  *_data;
}

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, strong) NSString *classifyName;

@end
