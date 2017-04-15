//
//  WGClientServiceCenterResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@interface WGClientServiceCenterResponse : WGResponse

@property (nonatomic, strong) NSArray *data;

@end

@interface WGClientServiceCenterItem : WGObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *url;

@end
