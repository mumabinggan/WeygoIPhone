//
//  WGUpdateResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@class WGUpdateData;

@interface WGUpdateResponse : WGResponse

@property (nonatomic, strong) WGUpdateData *data;

@end

@interface WGUpdateData : WGObject

@property (nonatomic, assign) int versionStatus;

@property (nonatomic, strong) NSString *versionCode;

@property (nonatomic, strong) NSString *updateTips;

@property (nonatomic, strong) NSString *linkUrl;

@property (nonatomic, assign) BOOL isForce;

@end
