//
//  WGAddressCityListResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@interface WGAddressCityListResponse : WGResponse

@property (nonatomic, strong) NSArray *data;

@end

@interface WGAddressCityListItem : JHObject

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *name;

@end
