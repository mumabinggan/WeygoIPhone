//
//  WGDeleteMessageRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGDeleteMessageRequest : WGRequest

@property (nonatomic, assign) long long messageId;

@end
