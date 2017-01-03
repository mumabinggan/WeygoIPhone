//
//  WGTopic.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGTopicItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *name;

@end
