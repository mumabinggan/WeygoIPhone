//
//  WGTitleItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGHome.h"

@interface WGTitleItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

//for self use
@property (nonatomic, strong) WGHome *data;

@end
