//
//  WGTopic.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

typedef NS_ENUM(NSInteger, WGTopicType) {
    WGTopicTypeNone
};

@interface WGTopicItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) WGAppJumpType jumpType;
//for dif skip
@property (nonatomic, assign) int requestParameter;

@end
