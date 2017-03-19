//
//  WGMessageReadResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGMessageItem.h"

@interface WGMessageReadResponse : WGResponse

@property (nonatomic, strong) WGMessageItem *data;

@end
